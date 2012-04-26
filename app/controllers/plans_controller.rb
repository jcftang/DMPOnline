class PlansController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  load_and_authorize_resource
  helper_method :sort_attribute, :sort_direction
  
  # GET /plans
  def index
    @plans = Plan
              .for_user(current_user)
              .where(user_id: current_user.id)
              .order("#{sort_attribute} #{sort_direction}")
              .page(params[:page])
              .per(15)
  end

  # GET /plans/shared
  def shared
    @plans = Plan
              .for_user(current_user)
              .where("plans.user_id <> ?", current_user.id)
              .order("#{sort_attribute} #{sort_direction}")
              .page(params[:page])
              .per(15)
  end

  # GET /plans/1
  def show
#    @plan = Plan.for_user(current_user).find(params[:id])
  end

  # GET /plans/new
  def new
#    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
#    @plan = Plan.for_user(current_user).find(params[:id])
  end

  # POST /plans
  def create
#    @plan = Plan.new(params[:plan])

    if @plan.save
      redirect_to @plan, notice: t('dmp.plan_created')
    else
      render :new
    end
  end

  # PUT /plans/1
  def update
#    @plan = Plan.for_user(current_user).find(params[:id])

    if @plan.update_attributes(params[:plan])
      redirect_to @plan, notice: t('dmp.plan_updated')
    else
      render :edit
    end
  end
  
  # DELETE /plans/1
  def destroy
#    @plan = Plan.for_user(current_user).find(params[:id])
    @plan.destroy

    redirect_to plans_url
  end
  
  # POST /plan/1/duplicate
  def duplicate
    # Since we may be duplicating a plan that includes now unpublished template phase editions we cannot 
    # allow the default creation of template_instances and phase_edition_instances to happen.  The entire
    # copy of the plan, template_instances, phase_edition_instances and answers is done with raw SQL.
    # This also avoids the overhead of all the validation which should be unnecessary.
    sql = ActiveRecord::Base.connection()

    plan_id = sql.insert_sql <<EOSQL
      INSERT INTO plans (project, currency_id, budget, start_date, end_date, lead_org, other_orgs, user_id, created_at, updated_at)
      SELECT CONCAT('[#{t('dmp.copy_stamp')} #{DateTime.now.to_s(:short)}] ', project), currency_id, budget, start_date, end_date, lead_org, other_orgs, 
          #{current_user.id}, now(), updated_at
        FROM plans
        WHERE id = #{@plan.id} 
EOSQL

    ti_list = {}
    @plan.template_instances.for_user(current_user).each do |ti|
      new_id = sql.insert_sql <<EOSQL
        INSERT INTO template_instances (template_id, plan_id, current_edition_id, created_at, updated_at, sword_col_uri)
        SELECT template_id, #{plan_id}, current_edition_id, now(), updated_at, sword_col_uri
        FROM template_instances
        WHERE id = #{ti.id}
EOSQL
      ti_list[ti.id] = new_id
    end

    new_pei_ids = [] 
    old_pei_ids = []
    @plan.phase_edition_instances.for_user(current_user).each do |pei|
      new_id = sql.insert_sql <<EOSQL
        INSERT INTO phase_edition_instances (template_instance_id, edition_id, created_at, updated_at, sword_edit_uri)
        SELECT #{ti_list[pei.template_instance_id]}, edition_id, now(), updated_at, sword_edit_uri
      FROM phase_edition_instances
      WHERE id = #{pei.id}
EOSQL
      old_pei_ids << pei.id
      new_pei_ids << new_id
    end

    sql.execute <<EOSQL      
      INSERT INTO answers (phase_edition_instance_id, question_id, dcc_question_id, answer, answered, hidden, position, created_at, updated_at)
      SELECT new_pei.id, a.question_id, a.dcc_question_id, a.answer, a.answered, a.hidden, a.position, now(), a.updated_at
      FROM phase_edition_instances old_pei INNER JOIN 
            answers a ON a.phase_edition_instance_id = old_pei.id AND old_pei.id IN (#{old_pei_ids.join(',')}) INNER JOIN
            editions e ON e.id = old_pei.edition_id INNER JOIN
            phase_edition_instances new_pei ON new_pei.edition_id = e.id AND new_pei.id IN (#{new_pei_ids.join(',')})
EOSQL

    redirect_to plans_url, notice: t('dmp.plan_created')
  end
  
  # PUT /plan/1/lock
  def lock
#    @plan = Plan.for_user(current_user).find(params[:id])

    if @plan.update_attribute(:locked, true)
      redirect_to plans_url, notice: t('dmp.plan_updated')
    else
      redirect_to plan_path(@plan), error: t('dmp.update_failed')
    end
  end

  # GET /plan/1/complete
  def complete
    if request.xhr?
      ti = @plan.template_instances.where(:template_id => params[:tid].to_i).first!
      section_id = params[:sid].to_i 
      if section_id > 0
        render partial: 'section', layout: false, locals: {section_id: section_id, ti: ti}
      else
        render partial: 'template', layout: false, locals: {ti: ti}
      end
    else
      render :complete
    end
  end

  # GET /plan/1/output
  def output

  end
  
  # GET /plan/1/section/1
  def ajax_section
    if request.xhr?
      answers = Answers.for_section(params[:question_id])
      render partial: 'section', layout: false, locals: {answers: answers}
    end
  end

  # PUT /plan/1/phase/1/set
  def change_phase
    ti = TemplateInstance
          .joins(:phase_edition_instances)
          .where('phase_edition_instances.edition_id' => params[:edition_id], :plan_id => @plan.id)
          .readonly(false)
          .first!

    if ti.update_attributes(:current_edition_id => params[:edition_id])
      pei = ti.phase_edition_instances.where(:edition_id => params[:edition_id]).first
      pei.rebuild_answers
      redirect_to plan_path(@plan), notice: "#{ti.template.organisation.short_name} #{ti.template.name}: #{t('dmp.phase_changed')}"
    else
      redirect_to plans_url
    end
  end
  
  # GET /plan/1/rights
  def rights
#    @plan = Plan.for_user(current_user).find(params[:id])

  end

  # PUT /plan/1/update_rights
  def update_rights
#    @plan = Plan.for_user(current_user).find(params[:id])

    err = false
    
    ti_vals = nil
    unless params[:plan].nil?
      ti_vals = params[:plan][:template_instances_attributes]
    end
    if ti_vals.nil?
      # Simple submission?
      tir_vals = params[:template_instance]
      if tir_vals.nil?
        err = true
      else
        @plan.template_instances.each do |ti|
          TemplateInstanceRight.delete_all(:template_instance_id => ti.id)
          unless ti.update_attributes(:template_instance_rights_attributes => tir_vals[:template_instance_rights_attributes])
            err=true
          end
        end
      end
    else
      # Advanced submission
      ti_vals.each do |k, v|
        unless v[:template_instance_rights_attributes].nil?
          ti = TemplateInstance
                  .where(:plan_id => @plan.id, :id => v[:id])
                  .readonly(false)
                  .first!
                  
          unless ti.update_attributes(:template_instance_rights_attributes => v[:template_instance_rights_attributes])
            err = true
          end
        end
      end
    end
    
    if err
      flash[:error] = I18n.t('dmp.invalid_emailmask')
      render :rights
    else
      redirect_to plan_path(@plan)
    end
  end

  
  
  
  private
  
  def sort_attribute
    %w[project start_date lead_org].include?(params[:sort]) ? params[:sort] : 'plans.created_at'
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'    
  end
    
end

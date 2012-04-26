class Answer < ActiveRecord::Base
  belongs_to :phase_edition_instance
  belongs_to :question
  belongs_to :dcc_question, :class_name => "Question", :foreign_key => "dcc_question_id"
  
  attr_accessible :answer, :hidden, :position, :question_id, :dcc_question_id
  attr_readonly :question_id, :dcc_question_id
  validate :not_locked
  after_validation :set_default_value
  before_create :get_initial_value
  before_save :set_answered_flag
  after_update :update_other_occurrences
    
  TOKENS = %w[project budget start_date end_date lead_org other_orgs]


  def all_live_occurrences
    self.phase_edition_instance.template_instance.plan.current_answers.where(dcc_question_id: self.dcc_question_id, hidden: false).uniq
  end
  
  def mapped_guide
    Mapping.where(question_id: self.question_id, dcc_question_id: self.dcc_question_id).first.try(:guide)
  end
  def question_guide
    self.question.try(:guide)
  end

  def mapped_boilerplates
    Mapping
      .select("boilerplate_texts.content")
      .joins(:boilerplate_texts).where(question_id: self.question_id, dcc_question_id: self.dcc_question_id)
      .all
  end
   
  protected
  
  def not_locked
    if self.phase_edition_instance.template_instance.plan.locked
      return errors.add(:base, I18n.t('dmp.locked_error'))
    end 
    true
  end
  
  def set_default_value
    if self.answer.blank?
      dv = self.question.default_value || self.dcc_question.try(:default_value)
      unless dv.blank?
        plan = self.phase_edition_instance.template_instance.plan
        self.answer = dv.gsub(/\[[a-z_]+\]/) {|m| expand_token(m[1..-2], plan)}
      end
    end
    true
  end
  
  def set_answered_flag
    stripped = ActionController::Base.helpers.strip_tags(self.answer) || ''
    stripped.strip!
    self.answered = !stripped.blank?
    true
  end
  
  def expand_token(token, plan)
    case token.to_sym
    when :project, :lead_org, :other_orgs
      plan.send(token.to_sym)
    when :budget
      if plan.currency.nil?
        ''
      else 
        "#{ActionController::Base.helpers.number_to_currency plan.budget, unit: plan.currency.symbol} (#{plan.currency.iso_code})"
      end
    when :start_date, :end_date
      l plan.send(token.to_sym), format: 'long'
    else
      "[#{token}]"
    end
  end

  def update_other_occurrences
    unless self.dcc_question_id.blank?
      Answer.update_all({:answer => self.answer, :answered => self.answered}, {:phase_edition_instance_id => self.phase_edition_instance.template_instance.plan.current_phase_edition_instance_ids, :dcc_question_id => self.dcc_question_id})
    end
  end
  
  def get_initial_value
    if self.answer.blank?
      d = Answer.joins(:phase_edition_instance)
            .where(:answered => true, :dcc_question_id => self.dcc_question_id, :phase_edition_instances => {:template_instance_id => self.phase_edition_instance.template_instance_id})
            .order('updated_at DESC')
            .first
      if d.try(:answered)
        self.answer = d.answer
        self.anwered = d.answered
      end
    end
  end
  
end

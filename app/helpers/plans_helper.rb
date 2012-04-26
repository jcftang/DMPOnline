# encoding: utf-8
module PlansHelper
  include QuestionsHelper
  
  def phase_progress(qc, ac)
    if qc.nil?
      ''
    elsif ac.blank? || ac == 0 
      t('dmp.not_started')
    elsif qc == 0
      t('dmp.no_questions')
    else
      pc = (100.0 * ac / qc).floor
      t('dmp.percent_complete', :pc => pc)
    end
  end

  def template_reference_list(answer, q_number)
    guidance_list = {}
    popup_set = false
    
    answer.all_live_occurrences.each do |a|
      ti = a.phase_edition_instance.template_instance

      if answer.id == a.id && !popup_set 
        popup = true
        popup_set = true
      else
        popup = false
      end
      
      guidance = ''
      if a.mapped_guide.try(:guidance).blank?
        if popup
          popup_set = false
        end
        if answer.id == a.id && !a.question_guide.try(:guidance).blank?
          guidance += controller.render_to_string partial: "plans/guidance", locals: {g: a.question_guide, popup: popup, org_name: ti.template.organisation.short_name, q_number: q_number}
        end
      else
        guidance += controller.render_to_string partial: "plans/guidance", locals: {g: a.mapped_guide, popup: popup, org_name: ti.template.organisation.short_name, q_number: q_number}
      end
      guidance += h(ti.template.organisation.short_name) + ' ' + h(ti.template.name) + ' (' + content_tag(:span, ti.current_edition.phase.phase, class: "phase") + ')'
      guidance_list[ti.id] = content_tag(:li, raw(guidance))
    end
    
    unless answer.dcc_question.try(:guide).try(:guidance).blank?
      if popup_set
        popup = false
      else
        popup = true
      end
      guidance = controller.render_to_string partial: "plans/guidance", locals: {g: answer.dcc_question.guide, popup: popup, org_name: 'DCC', q_number: q_number}
      guidance += t('dmp.dcc_guidance')
      guidance_list['dcc'] = content_tag(:li, raw(guidance))
    end

    content_tag(:ul, raw(guidance_list.values.join), class: "template-reference-list")
  end

  def get_numbered_section_questions(edition, section_id)
    qs = number_questions(edition.section_questions(section_id))
    qs.delete_if { |q| q.id != section_id && q.parent_id.blank? }
  end

  def sortable_header(attr)
    attr = attr.to_s
    css_class = attr == sort_attribute ? "sortable current sorted-#{sort_direction}" : "sortable"
    direction = attr == sort_attribute && sort_direction == 'asc' ? 'desc' : 'asc'
    content_tag :th, link_to(t("attributes.#{attr}"), {sort: attr, direction: direction}), class: css_class
  end
  
  def boilerplate_list(answer)
    bps = answer.mapped_boilerplates.collect(&:content)
    unless answer.question.try(:boilerplate_texts).blank?
      bps += answer.question.boilerplate_texts.collect(&:content)
    end
    unless answer.dcc_question.try(:boilerplate_texts).blank?
      bps += answer.dcc_question.boilerplate_texts.collect(&:content)
    end
    
    bp_block = ''
    if bps.any?
      bp_block = controller.render_to_string partial: "plans/boilerplate", locals: {bps: bps}
    end
    bp_block.html_safe
  end
  
  def plan_rights_list
    exclusion = %w[owner none]
    TemplateInstance::ROLES.inject({}) do |hash, r|
      unless exclusion.include?(r)
        hash.merge!(I18n.t("dmp.roles.#{r}") => TemplateInstance::ROLES.index(r))
      else
        hash
      end
    end
  end
  
  def display_email_mask(mask)
    unless mask.nil?
      mask.gsub(/\\/, '').tr('%', '*')
    end
  end
  
  def plan_created_by(plan)
    if plan.user_id == current_user.id
      ''
    else
      I18n.t('dmp.shared_by', user: plan.user.email)
    end
  end

end

# encoding: utf-8
module PhaseEditionInstancesHelper
  include QuestionsHelper
  
  def export_questions(pei, selection = [])
    export_dmp = []
    export_section = {}
    export_section[:template_clauses] = []
    export_section[:q_id] = 0
    export_question = {}
      
    qs = pei.report_questions
    if selection.empty?
      selection = exclude_conditionals(qs, pei)
    end
    apply_selection(qs, selection)
    number_questions(qs)
    if pei.is_a?(Plan)
      dcc_q_numbering = dcc_numbering(pei.template_instances.first.current_edition) 
    else
      dcc_q_numbering = dcc_numbering(pei.edition)
    end
    
    first = true
    qs.each do |q|
      if (q.depth == 0 && q.is_heading?)
        unless first
          export_dmp << export_section
        end
        export_section = {}
        export_section[:number] = q.number_display
        export_section[:heading] = sanitize q.question.force_encoding('UTF-8')
        export_section[:template_clauses] = []
        export_section[:q_id] = q.id
      end
      export_question = {}
      export_question[:number] = q.number_display
      export_question[:depth] = q.depth
      export_question[:kind] = q.kind
      export_question[:is_heading] = q.is_heading?
      export_question[:is_mapped] = q.is_mapped?        
      export_question[:question] = sanitize q.question.force_encoding('UTF-8')
      export_question[:answers] = []
      
      if !q.is_mapped? && !q.is_heading?
        if pei.is_a?(PhaseEditionInstance)
          q_answers = pei.question_answers(q.id)
        else
          q_answers = []
          pei.phase_edition_instances.each do |p|
            q_answers |= p.question_answers(q.id)
          end
        end
        q_answers.each do |d|
          export_answer = {}
          export_answer[:dmp_number] = ''
          export_answer[:dmp_clause] = t('dmp.no_dcc_equivalent')
          if q.kind == 'b'
            if d.answered
              export_answer[:response] = (d.answer.to_i > 0) ? t('dmp.boolean_yes') : t('dmp.boolean_no')
            else
              export_answer[:response] = ''
            end
          else
            export_answer[:response] = d.answer.nil? ? '' : d.answer.force_encoding('UTF-8')
          end
          export_question[:answers] << export_answer
        end
      elsif q.is_mapped?
        @phase_edition_instance.question_answers(q.id).each do |d|
          unless d.dcc_question.nil?
            export_answer = {}
            export_answer[:dmp_number] = "DCC #{dcc_q_numbering[d.dcc_question.id]}"
            export_answer[:dmp_clause] = sanitize d.dcc_question.question
            export_answer[:kind] = d.dcc_question.kind
            if d.dcc_question.kind == 'b'
              if d.answered
                export_answer[:response] = (d.answer.to_i > 0) ? t('dmp.boolean_yes') : t('dmp.boolean_no')
              else
                export_answer[:response] = ''
              end
            else
              export_answer[:response] = d.answer.nil? ? '' : d.answer.force_encoding('UTF-8')
            end
            export_question[:answers] << export_answer
          end
        end
      end
      
      # Don't include the heading if it's just a repeat of the section
      unless export_section[:q_id] == q.id && q.is_heading?
        export_section[:template_clauses] << export_question
      end
      
      first = false
    end

    unless export_section.blank?
      export_dmp << export_section
    end
    
    export_dmp
  end

  def exclude_conditionals(qs, pei)
    dv = pei.answers.where(:answered => true).inject({}) do |hash, a|
      hash.merge!((a.dcc_question_id ? a.dcc_question_id : a.question_id) =>  a.answer)
    end
    selection = []
    qs.each do |q|
      if q.dependency_question_id 
        if q.dependency_value.split('|').include?(dv[q.dependency_question_id])
          selection << q.id
        end
      else
        selection << q.id
      end
    end
    selection
  end
        
  def apply_selection(qs, selection)
    qs.delete_if{ |q| !selection.include?(q.id) }
    qs.sort!{ |a,b| selection.index(a.id) <=> selection.index(b.id) }
    
    # Always start with a section header
    if qs.any?
      qs.first.parent_id = nil
    end
  end


end

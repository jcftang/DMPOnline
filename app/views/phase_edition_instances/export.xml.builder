xml.instruct!
xml.dmp do
  xml.project_name(plan_display(@plan, :project))
  xml.format do
    xml.header(@doc[:page_header_text])
    xml.footer(@doc[:page_footer_text])
    xml.font_face(@doc[:font_style])
    xml.font_size(@doc[:font_size])
    xml.signatures(@doc[:page_signatures_count])
  end
  if @doc[:project_status]
    xml.stage(t('dmp.project_stage', phase: @phase_edition_instance.edition.phase.phase))
  end
  if @doc[:template_org]
    xml.template_org("#{@phase_edition_instance.template_instance.template.organisation.organisation_type.title}: #{@phase_edition_instance.template_instance.template.organisation.full_name}")
  end
  if @doc[:partners]
    xml.lead_org(plan_display(@plan, :lead_org))
    xml.other_orgs(plan_display(@plan, :other_orgs))
  end
  if @doc[:project_dates]
    unless @plan.start_date.nil? 
      xml.project_start(plan_display(@plan, :start_date))
      unless @plan.end_date.nil?
        xml.project_end(plan_display(@plan, :end_date))
      end
    end
  end
  if @doc[:budget]
    xml.budget(plan_display(@plan, :budget))
  end
  
  qs = export_questions(@pei, @doc[:selection])
  qs.each do |s|
    xml.section("number" => s[:number]) do
      xml.heading(strip_tags(s[:heading]))
      s[:questions] ||= []
      s[:questions].each do |q|
        xml.dcc_clause do
          xml.question(strip_tags(q[:dmp_clause]), "number" => q[:dmp_clause_number])
          xml.response(q[:response])
        end
      end
      s[:template_clauses] ||= []
      s[:template_clauses].each do |q| 
        xml.template_clause do
          xml.question(strip_tags(q[:question]), "number" => q[:number])
          q[:answers].each do |a|
            xml.dcc_clause do
              dcc_number = @doc[:dcc_question_numbers] ? a[:dmp_number].slice(4..-1) : ''
              dcc_clause = @doc[:include_dcc_questions] ? strip_tags(a[:dmp_clause]) : ''
              xml.question(dcc_clause, "number" => dcc_number)
              xml.response(a[:response])
            end
          end
        end
      end
    end
  end
end
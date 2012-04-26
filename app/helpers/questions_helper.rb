module QuestionsHelper

  def number_part(number = -1, style = '')
    return '' if number < 1
    
    case style.to_sym
    when :I
      number.to_s_roman.upcase
    when :i
      number.to_s_roman.downcase
    when :A
      return 'A' if number == 1
      number -= 1
      c = []
      while number > 0
        d = number.divmod(26)
        c << (65 + d[1])
        number = d[0]
      end
      c.pack('c*')
    when :a
      return 'a' if number == 1
      number -= 1
      c = []
      while number > 0
        d = number.divmod(26)
        c << (97 + d[1])
        number = d[0]
      end
      c.pack('c*')
    when :X
      ''
    else
      number
    end
  end
  
  def number_questions(questions)
    previous = [0]
    level = 0
    numbering = []
    display = []
    questions.each do |q|
      level = previous.index(q.parent_id.to_i)
      if level.nil?
        level = previous.size
        previous[level] = q.parent_id.to_i
      end
      previous = previous.first(level+1)
      numbering = numbering.first(level+1)
      
      numbering[level] ||= 0
      numbering[level] += 1
      display[level] = number_part(numbering[level], q.number_style) || ''
      numbering[level] -= 1 if display[level] == ''
      number_display = ''
      level.times do |i|
        if display[i] == ''
          number_display = ''
        else
          number_display += "#{display[i]}."
        end
      end
      q.number_display = "#{number_display}#{display[level]}"
      q.depth = level
    end
    questions
  end

  def translated_styles
     Question::NUMBER_STYLES.keys.inject({}) do |hash, k|  
       hash.merge!(I18n.t("dmp.styles.#{k}") => Question::NUMBER_STYLES[k])
     end
  end

  def translated_types
     Question::TYPES.keys.inject({}) do |hash, k| 
       hash.merge!(I18n.t("dmp.types.#{k}") => Question::TYPES[k])
     end
  end
  
  def question_type_css(kind)
    Question::TYPES.invert[kind]
  end
  
  def mapped_kind_option
    l = translated_types.invert['m']
    {l => 'm'}
  end

  def dcc_checklist_taken_edition(q)
    Question
    .select('DISTINCT dcc_question_id, question')
    .joins(:mappings)
    .where('questions.edition_id' => q.edition_id)
    .where('questions.id <> ?', q.id.to_i)
    .select('questions.id AS id, mappings.dcc_question_id AS dcc_question_id')
    .inject({}) do |hash, m|
      hash.merge!(m.dcc_question_id => truncate(strip_tags(m.question), :length => 50))
    end
  end

  def dcc_checklist_questions(e)
    dcc = Edition.where(id: e.dcc_edition_id.to_i).first
    if dcc.blank?
      []
    else
      number_questions(dcc.sorted_questions)
    end
  end
  
  def dcc_checklist_pick(e)
    display_numbered_questions(dcc_checklist_questions(e))
  end
  
  def dcc_numbering(e)
    qs = dcc_checklist_questions(e)
    qs.inject({}) do |hash, q|
      hash.merge!(q.id => q.number_display) 
    end   
  end

  def question_type_title(k)
    types = Question::TYPES.invert
    types[k].humanize
  end

  def dcc_checklist_editions
    Edition.dcc_checklist_editions.inject({}) do |hash, v| 
      hash.merge!("#{v.short_name} #{v.phase.phase} [#{v.edition}]" => v.id) 
    end
  end
  
  def dependency_question_options(question)
    qs = Question.questions_in_edition(question)
    display_numbered_questions(number_questions(qs), [question.id])
  end
  def dependency_dcc_question_options(question)
    q = Question.new(:edition_id => question.edition.dcc_edition_id.to_i)
    qs = Question.questions_in_edition(q)
    display_numbered_questions(number_questions(qs), [question.id])
  end

  def display_numbered_questions(c, omit = [])
    c.inject({}) do |hash, q|
      if omit.include?(q.id) || q.is_heading? || q.is_mapped?
        hash
      else
        hash.merge!("#{q.number_display} #{abbreviated_question(q)}" => q.id)
      end
    end
  end

  def abbreviated_question(q)
    truncate(strip_tags(q.question), :length => 200)
  end

end

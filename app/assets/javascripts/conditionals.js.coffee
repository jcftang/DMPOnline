# Routines to hide divs dependent on values entered into a specified field

jQuery ->
  conditional_show = (source, target, triggers) ->
    if source.substr(source.length - 8) == ':checked'
      i_source = source.substr(0, source.length - 8)
      $(i_source).on 'change', ->
        if jQuery.inArray($(this).parents("ol").find("input:checked").val(), triggers) >= 0
          $(target).show()
        else
          $(target).hide()        
    else
      $(source).on 'change', ->
        if jQuery.inArray($(this).val(), triggers) >= 0
          $(target).show()
        else
          $(target).hide()  
    $(source).trigger('change')
    
  # Admin Question page  
  conditional_show('#question_kind', '#boilerplate_collapsible', ['t'])
  conditional_show('#question_kind', '#mapping_collapsible', ['m'])
  conditional_show('#question_kind', '#question_default_value_input', ['t'])

  # Plan completion
  window.plan_conditionals = () ->
    $('table.plan tbody tr').each ->
      dq = $(this).data('dependency')
      dv = $(this).data('being')
      unless dq == undefined || dv == undefined
        dvl = dv.toString().split('|')
        conditional_show(dq, '#' + $(this).attr('id'), dvl)

    $(".ui-tabs-panel:not(.ui-tabs-hide) dl.boilerplate dt").click -> 
      $(this)
        .toggleClass('expanded collapsed')
        .next()
        .slideToggle('slow')
      $(this).find("span").toggleClass('ui-icon-triangle-1-e ui-icon-triangle-1-s')
    
    $(".ui-tabs-panel:not(.ui-tabs-hide) dl.boilerplate dt").prepend('<span class="ui-icon ui-icon-triangle-1-s">')
    $(".ui-tabs-panel:not(.ui-tabs-hide) dl.boilerplate dt")
      .addClass('expanded')
      .trigger('click')
  
  # Plan output
  conditional_show('#format', '#page_layout', ['pdf', 'docx', 'rtf', 'html'])
  
  # Collapsibles
  $(".collapsible legend").click -> 
    $(this)
      .toggleClass('expanded collapsed')
      .next()
      .slideToggle('slow')
    $(this).find("span>span").toggleClass('ui-icon-triangle-1-e ui-icon-triangle-1-s')
      
  $(".collapsible legend span").prepend('<span class="ui-icon ui-icon-triangle-1-s">')
  $(".collapsible legend")
    .addClass('expanded')
    .trigger('click')
  
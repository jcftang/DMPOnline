# Accordion using jQuery UI http://jqueryui.com (as are tabs - JS in plans/template partial)

jQuery ->
  @ie_disable = 'NONE'
  if jQuery.browser.msie && (parseInt(jQuery.browser.version) < 9)
    @ie_disable = 'TABS'
  if jQuery.browser.msie && (parseInt(jQuery.browser.version) < 8)
    @ie_disable = 'ACCORDION'

  $("#rights_tabs").tabs()

  @guidance_dialogue = '' 
  
  guidance_blocks = () ->
    $(".guidance-area .dialogue").livequery ->
      $(this).dialog("destroy")
    $(".guidance-area .dialogue").livequery ->
      $(this).dialog
        autoOpen: false
        show: 'fold'
        hide: 'clip'
        # position: 'right'
        height: 300
        width: 400
        modal: false

    $("a.guidance-button").livequery "click", (event) ->
      event.preventDefault()
      event.stopPropagation()
      ref = $(this).data("guide")
      $("#dialogue-" + ref).dialog("open")
      $("#dialogue-" + ref).dialog("moveToTop")

    $(".dialogue a").livequery ->
      $(this).unbind("click").click (event) ->
        event.preventDefault()
        event.stopPropagation()
        window.open(this.href, '_blank')
      

  guidance_hovers = () ->
    $("#templates .answer li.input.radio").livequery ->
      $(this).mouseenter -> 
        open_guidance(this)
        return
      .mouseleave ->
        close_guidance()
        return

    $("#templates .answer li.input.text textarea").livequery ->
      $(this).focusin ->
        open_guidance(this)
        return
        
    $("#templates .answer li.input.text textarea").livequery ->
      $(this).focusout ->
        close_guidance()
        return

    $("#templates .answer li.input.url input").livequery ->
      $(this).focusin ->
        open_guidance(this)
        return

    $("#templates .answer li.input.url input").livequery ->
      $(this).focusout ->
        close_guidance()
        return

  open_guidance = (e) =>
    ref = $(e).parents("tr").find("td.guidance-area div.popup a.guidance-button").data("guide").toString()
    unless ref.length == 0
      dialogue = "#dialogue-" + ref
      unless $(dialogue).dialog("isOpen")
        close_guidance()
        # Nasty workaround to stop dialog stealing focus...
        $(dialogue).dialog("widget").css("visibility", "hidden");  
        $(dialogue).dialog("open")
        $(dialogue).dialog("widget").css("visibility", "visible");
        @guidance_dialogue = dialogue
      $(dialogue).dialog("moveToTop")

  close_guidance = () =>
    if @guidance_dialogue.length
      $(@guidance_dialogue).dialog("close")
      @guidance_dialogue = ''


  unless @ie_disable == 'ACCORDION'
    $("#templates.accordion .panel").accordion 
      active: ".current", 
      clearStyle: true,
      autoHeight: false,
      event: '',
      changestart: (event, ui) => 
        href = $(ui.newHeader.find("a")).attr("href") 
        $.get href, (data) ->
          ui.newHeader.next("div").html(data)

    $('#templates.accordion .ui-accordion-header a').click ->
      i = $('#templates.accordion .ui-accordion-header a').index(this) 
      
      if $("form.phase_edition_instance").isDirty() && !confirm 'You have unsaved changes.  Are you sure you want to navigate away?'
        return false
      
      $("form.phase_edition_instance").cleanDirty()
      $("#templates.accordion .panel").accordion('activate', i)
      return false


  $("form.phase_edition_instance").livequery ->
    $(this).dirtyForms()
  $(".hide_opt").livequery ->
    $(this).after('<a class="hide-link" href="#">[Hide]</a>').next("a").on "click", ->
      $(this).prev().find("input[type=hidden]").val("1")
      $(this).closest("form").setDirty()
      $(this).closest("tr").slideUp()

  guidance_blocks()
  # guidance_hovers()
  plan_conditionals()

  if @ie_disable == 'NONE'
    $("#templates.accordion .ui-accordion-content-active .sections").livequery ->
      $(this).tabs
        cache: false
        ajaxOptions:
          cache: false
        event: ''
        load: (event, ui) -> 
          $("#templates.accordion .ui-accordion-content-active .sections ol a").removeAttr("title")    
        spinner: $("#templates").data('preloader')
  
    $('#templates.accordion .ui-accordion-content-active .ui-tabs-nav a').livequery "click", (event) ->
      event.stopImmediatePropagation()
      
      if $("form.phase_edition_instance").isDirty() && !confirm 'You have unsaved changes.  Are you sure you want to navigate away?'
        return false
      
      $("form.phase_edition_instance").cleanDirty()
      i = $('#templates.accordion .ui-accordion-content-active .ui-tabs-nav a').index(this)
      $("#templates.accordion .ui-accordion-content-active .sections").tabs( "option", "event", 'click' )
      $("#templates.accordion .ui-accordion-content-active .sections").tabs('select', i)
      $("#templates.accordion .ui-accordion-content-active .sections").tabs( "option", "event", '' )
      return false

  # Hide the position field and boilerplate text.  Done here so degrades if JS not running
  $('head').append '<style>div.hide_opt { display: none; }</style>'

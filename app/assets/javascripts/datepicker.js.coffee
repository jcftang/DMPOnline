jQuery ->
  $("ol.fragments-group").each (i, element) ->
    @el = $(element)
    @yr = @el.find('li select[id$="_1i"]')
    @mn = @el.find('li select[id$="_2i"]')
    @dy = @el.find('li select[id$="_3i"]')
    
    mindate = new Date()
    maxdate = new Date()
    mindate.setFullYear(mindate.getFullYear() - 5)
    mindate.setMonth(0)
    mindate.setDate(1)
    maxdate.setFullYear(maxdate.getFullYear() + 5)
    maxdate.setMonth(11)
    maxdate.setDate(31)

    li = document.createElement('li')
    $(li).addClass('fragment')
    input = document.createElement('input')
    $(input).addClass('ui-datepicker-tmp').attr
      type: "hidden"
      value: @yr.value + '-' + @mn.value + '-' + @dy.value
    $(li).append(input)

    @el.append(li).find('.ui-datepicker-tmp').datepicker
      showOn: 'button'
      dateFormat: 'yy-mm-dd'
      buttonImage: '/assets/datepicker/datepicker-input-icon.png'
      buttonText: "Open calendar"
      buttonImageOnly: true
      minDate: mindate
      maxDate: maxdate
      showAnim: 'fadeIn'
      beforeShow: (input, inst) =>
        if @yr.val() && @mn.val() && @dy.val()
          $(input).datepicker('setDate' , @yr.val() + '-' + ('0' + @mn.val()).slice(-2) + '-' + ('0' + @dy.val()).slice(-2))
      onSelect: (dateText, inst) =>
        d = dateText.split('-')
        @yr.val(d[0])
        @mn.val(d[1].replace(/^0+/, ''))
        @dy.val(d[2].replace(/^0+/, ''))

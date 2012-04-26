# Place all the behaviors and hooks related to sorting here.
# All this logic will be available in all active_admin pages.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#sortable>ol').sortable
    axis: 'y'
    cursor: 'move'
    containment: '#sortable'
    handle: '.handle'
    placeholder: 'ui-state-highlight'
    update: ->
      $('li.sort-position>input[type=number]').each (i, element) ->
        $(element).val(i + 1) 

  # Hide the position field.  Done here so degrades if JS not running
  $('head').append '<style>#sortable li.sort-position { display: none; }</style>'
  
  $('.add_fields').parent().on 'insertion-callback', ->
    $('li.sort-position>input[type=number]').each (i, element) -> 
      $(element).val(i + 1)

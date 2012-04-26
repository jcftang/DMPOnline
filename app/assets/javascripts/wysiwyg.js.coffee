jQuery ->
  $('textarea.wysiwyg').tinymce
    theme: 'advanced'
    plugins: "autolink,lists,table,advimage,advlink,media,contextmenu,paste,xhtmlxtras"
    theme_advanced_toolbar_location: 'top'
    theme_advanced_toolbar_align: 'left'
    theme_advanced_statusbar_location: 'bottom'
    theme_advanced_resizing: true
    content_css: '/assets/active_admin.css'
    theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,outdent,indent,blockquote,|,sub,sup,|,cut,copy,paste,pastetext,pasteword,|,undo,redo,|,removeformat,cleanup,code",
    theme_advanced_buttons2: "link,unlink,anchor,image,|,tablecontrols,visualaid,|,hr,|,charmap,media,|,abbr,acronym,|,formatselect",
    theme_advanced_buttons3: ""
    theme_advanced_buttons4: ""
    height: "150px"

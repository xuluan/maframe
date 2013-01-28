$ = jQuery.sub()

class App.JobSegyin extends Spine.Model
  @configure 'JobSegyin', 'name', 'template', 'path', 'infile'
  
  defaults:
    "infile": "in.segy"
  
  constructor: (atts) ->
    att = atts
    atts = 
      name: att.name
      template: att.template
      path: att.path
    atts = $.extend(atts, @defaults)
    super
    


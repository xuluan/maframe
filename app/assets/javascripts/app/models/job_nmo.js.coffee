$ = jQuery.sub()

class App.JobNMO extends Spine.Model
  @configure 'JobNMO', 'name', 'template', 'path', 'in_file', "velocity", "out_file"
  
  defaults:
    "in_file": "host_b:/prj/nmo_in.rsf"
    "velocity": 1500  #(0-5000)
    "out_file": "host_b:/prj/nmo_out.rsf"
  
  constructor: (atts) ->
    att = atts
    atts = 
      name: att.name
      template: att.template
      path: att.path
    atts = $.extend(@defaults, atts)
    super
    

  validate: ->
    unless 0 < @velocity < 5000
      "Velocity should be 0 - 5000"
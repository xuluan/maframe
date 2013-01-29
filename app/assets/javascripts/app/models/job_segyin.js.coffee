$ = jQuery.sub()

class App.JobSegyin extends Spine.Model
  @configure 'JobSegyin', 'name', 'template', 'path', 'type', 'in_file', 'rsf_file', 'trace_file', 'header_file'
  
  defaults:
    "in_file": "host_a:/in.segy"
    "rsf_file": "host_b:/prj/out.rsf"
    "trace_file": "host_b:/prj/trace_header.rsf"
    "header_file": "host_b:/prj/header.txt"  

  constructor: (atts) ->
    att = $.extend({}, @defaults, atts)
    atts = {}
    for key in App.JobSegyin.attributes
      atts[key] = att[key]
    super
    


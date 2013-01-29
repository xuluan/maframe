$ = jQuery.sub()
Jobs = App.Jobs
JobSegyin = App.JobSegyin
JobNMO = App.JobNMO

$.fn.templateName = ->
  template  = $(@).data('template')
  template or= $(@).parents('[data-template]').data('template')
  
class Show extends Spine.Controller
  className: 'show'
  
  constructor: ->
    super
    @active @change if @item

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view('jobs/show')(item)

  change: (params) =>
    @render()

class Edit extends Spine.Controller
  className: 'edit'
  factory:
    "Segyin": (item) ->
      JobSegyin.create(item)
    "NMO": (item) ->
      JobNMO.create(item)
      
  constructor: ->
    super
    @active @change 

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view('template/'+ item.template)(item)

  change: (params) =>
    @item = @factory[params.template](params)
    @render()

class Create extends Spine.Controller
  className: 'create'
  events:
    'click a.template': 'selTemplate'

  constructor: ->
    super
    @active @change 

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view('jobs/create')(item)

  change: (params) =>
    if params.template is "none"
      @item = params
      @render()
    else 
      @navigate('/jobs/edit', params)
 
  selTemplate: (e) =>
    @item.template = $(e.target).templateName()
    @navigate('/jobs/edit', @item)

class App.Jobs extends Spine.Stack
  className: 'job stack'
    
  controllers:
    show: Show
    edit: Edit
    create: Create


    



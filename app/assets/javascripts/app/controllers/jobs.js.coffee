$ = jQuery.sub()
Jobs = App.Jobs
Node = App.Node

JobSegyin = App.JobSegyin
JobNMO = App.JobNMO

$.fn.templateName = ->
  template  = $(@).data('template')
  template or= $(@).parents('[data-template]').data('template')

Factory =
  "Segyin": JobSegyin
  "NMO": JobNMO

class Show extends Spine.Controller
  className: 'show'
  
  constructor: ->
    super
    @active @change

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view("template/#{item.template}-show")(item)

  change: (params) =>
    @item = Factory[params.template].find(params.id)
    @render()

class Edit extends Spine.Controller
  className: 'edit'

  events:
    'submit form': 'save'
    'reset form': 'cancel'
      
  constructor: ->
    super
    @active @change 

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view("template/#{item.template}-edit")(item)

  change: (params) =>
    @item = Factory[params.template].create(params)
    @render()

  save: (e) =>
    e.preventDefault()
    @item.fromForm(e.target).save()
    Node.fetch(cmd: "update", path: @item.path, job: @item.toJSON())
    @close()

  cancel: =>
    @close()

  close: =>
    @navigate('/jobs', @item.template, @item.cid)


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
    @item = params
    @render()
 
  selTemplate: (e) =>
    @item.template = $(e.target).templateName()
    @navigate('/jobs/edit', @item)

class App.Jobs extends Spine.Stack
  className: 'job stack'
    
  controllers:
    show: Show
    edit: Edit
    create: Create


    



$ = jQuery.sub()
Jobs = App.Jobs


class Show extends Spine.Controller
  className: 'show'
  
  constructor: ->
    console.log("show init")
    super
    @active @change

  render: ->
    console.log("show render")
    @html(@template(@item))

  template: (item) ->
    @view('jobs/show')(item)

  change: (params) =>
    @render()

class Edit extends Spine.Controller
  className: 'edit'
  
  constructor: ->
    console.log("edit init")
    super
    @active @change

  render: ->
    console.log("edit render")
    @html(@template(@item))

  template: (item) ->
    @view('jobs/edit')(item)

  change: (params) =>
    @item = {}
    @render()

class App.Jobs extends Spine.Stack
  className: 'job stack'
    
  controllers:
    show: Show
    edit: Edit


    



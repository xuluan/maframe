$ = jQuery.sub()
Jobs = App.Jobs


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
  
  constructor: ->
    super
    @active @change 

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view('jobs/edit')(item)

  change: (params) =>
    @item = params
    @render()

class Create extends Spine.Controller
  className: 'create'
  
  constructor: ->
    super
    @active @change 

  render: ->
    @html(@template(@item))

  template: (item) ->
    @view('jobs/create')(item)

  change: (params) =>
    # @navigate('/jobs/edit', params)
    @item = params
    @render()


class App.Jobs extends Spine.Stack
  className: 'job stack'
    
  controllers:
    show: Show
    edit: Edit
    create: Create


    



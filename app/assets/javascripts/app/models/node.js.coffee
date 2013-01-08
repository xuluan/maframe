class App.Node extends Spine.Model
  @configure 'Node', 'name', 'tree', 'path', 'type', 'prj'
  @extend Spine.Model.Ajax.Methods
  
  @fetch (params) ->
    @prj  = window.prjName
    
    params or= 
      data: {prj: @prj}
      processData: true

    @ajax().fetch(params)


class App.Node extends Spine.Model
  @configure 'Node', 'name', 'tree', 'path', 'type', 'prj'
  @extend Spine.Model.Ajax.Methods
  
  @fetch (data) ->
    data or= 
      prj: window.prjName
    
    params = 
      data: data
      processData: true

    @ajax().fetch(params)


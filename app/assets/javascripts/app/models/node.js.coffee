class App.Node extends Spine.Model
  @configure 'Node', 'name', 'tree', 'path', 'type', 'prj'
  @extend Spine.Model.Ajax.Methods
  
  @fetch (params) ->
    @prj  = window.prjName
    
    params or= 
      data: {prj: @prj}
      processData: true

    @ajax().fetch(params)

  @change (record, type, options = {}) ->
    return if options.ajax is false
    record.ajax()[type](options.ajax, options)    

  list: (tree) ->
    JST["app/views/nodes/list"](tree)
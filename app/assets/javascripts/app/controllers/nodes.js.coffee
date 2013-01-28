$ = jQuery.sub()
Node = App.Node
Jobs = App.Jobs

class NodeItem extends Spine.Controller
  # Delegate the click event to a local handler
  tag: 'li'
  className: 'node'
  elements:
    ".node-list": "list"

  events:
    'click a.node-fold': 'click'
    'click a.remove': 'remove'
    'click a.add-fold': 'addFold'
    'click a.create-job': 'createJob'
    'click a.edit': 'edit'


  # Bind events to the record
  constructor: ->
    super
    throw "@item required" unless @item

  render: (item) =>
    @item = item if item
    @html(@template(@item))
    if @item.tree 
      @showTree(@item.tree)
    @

  # Use a template, in this case via Eco
  template: (item) ->
    @view('nodes/show')(item)

  showTree: (tree) =>
    for elem in tree
      node = Node.create(elem)
      nodeitem = new NodeItem(item: node)
      @list.append(nodeitem.render().el) 

  click: (e)  =>
    @$("ul.node-list").first().toggle()
    $(e.target).toggleClass("icon-plus-sign icon-minus-sign")
    false
    
  remove: (e) ->
    if confirm('Delete it, sure?')
      @item.destroy()
      @el.remove()
      Node.fetch(cmd: "rm", path: @item.path)
    false
  
  addFold: (e) =>
    name = prompt("Please enter new fold name:")
    if name
      item = {name: name, path: @item.path+"/"+name, type: "dir", tree: []}
      node = Node.create(item)
      nodeitem = new NodeItem(item: node)
      @list.append(nodeitem.render().el)
      Node.fetch(cmd: "mkdir", path: node.path)
    @$('.dropdown-toggle').first().dropdown('toggle')
    false

  createJob: (e) =>
    @navigate('/sidebar')
    name = prompt("Please enter new job name:")
    if name
      item = {name: name, path: @item.path+"/"+name, type: "file", template: "none"}
      node = Node.create(item)
      nodeitem = new NodeItem(item: node)
      @list.append(nodeitem.render().el)
      Node.fetch(cmd: "create", path: node.path, job: item)
    @$('.dropdown-toggle').first().dropdown('toggle')
    false

  edit: (e) =>
    @navigate('/sidebar')
    Node.fetch(cmd: "fetch", path: @item.path)
    @$('.dropdown-toggle').first().dropdown('toggle')
    false

class Sidebar extends Spine.Controller
  className: 'sidebar'
  
  elements:
    "#nodes": "nodes"

  constructor: ->
    super
    root = $('<ul id="nodes" />')
    @append root

    Node.bind("refresh", @addAll)
    Node.fetch()
    @

  addOne: (item) =>
    node = new NodeItem(item: item)
    @nodes.append(node.render().el)

  gotJob: (item) =>
    @navigate('/jobs/create', item)

  addAll: (items = []) =>
    for item in items
      @addOne(item) if item.type is "dir"
      @gotJob(item) if item.type is "file"

class App.Main extends Spine.Controller

  el: "#main"
  
  constructor: ->
    super
    
    @sidebar = new Sidebar
    @job     = new Jobs
    
    @routes
      '/jobs/create': (params) -> 
        @job.create.active(params)    
      '/jobs/edit': (params) -> 
        @job.edit.active(params)
      '/jobs/:id': (params) ->
        @job.show.active(params)

   
    @append @sidebar, @job

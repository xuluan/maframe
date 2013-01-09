$ = jQuery.sub()
Node = App.Node

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

  # Bind events to the record
  constructor: ->
    super
    throw "@item required" unless @item

  render: (item) =>
    @item = item if item
    @html(@template(@item))
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
    false
  
  addFold: (e) =>
    name = prompt("Please enter new fold name:")
    console.log("a")
    if name
      console.log(name)
      item = {name: name, path: @item.path+"/"+name, type: "dir", tree: []}
      node = Node.create(item)
      nodeitem = new NodeItem(item: node)
      @list.append(nodeitem.render().el)
    @$('.dropdown-toggle').first().dropdown('toggle')
    false


class App.Main extends Spine.Controller

  el: "#main"
  elements:
    "#nodes": "nodes"

  constructor: ->
    super
    Node.bind("refresh", @addAll)
    Node.fetch()
    @

  addOne: (item) =>
    node = new NodeItem(item: item)
    @nodes.append(node.render().el)

  addAll: (items = []) =>
    for item in items
      @addOne(item)

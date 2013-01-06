$ = jQuery.sub()
Node = App.Node

class NodeItem extends Spine.Controller
  # Delegate the click event to a local handler

  className: 'node'

  # Bind events to the record
  constructor: ->
    super
    throw "@item required" unless @item

  render: (item) =>
    @item = item if item
    @html(@template(@item))
    @

  # Use a template, in this case via Eco
  template: (item) ->
    @view('nodes/show')(item)


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

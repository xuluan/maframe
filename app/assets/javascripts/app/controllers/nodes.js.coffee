$ = jQuery.sub()
Node = App.Node


class App.Main extends Spine.Controller

  el: "#main"
  elements:
    ".nodes": "nodes"

  constructor: ->
    super
    Node.bind("refresh", @addAll)
    Node.fetch()
    @


  addAll: (items = []) =>
    console.log(items)

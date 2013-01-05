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
    @addFilter()
    @


  addAll: (items = []) =>
    window.console(items)

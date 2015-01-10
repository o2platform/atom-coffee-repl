AtomCoffeeReplView = require './atom-coffee-repl-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomCoffeeRepl =
  atomCoffeeReplView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomCoffeeReplView = new AtomCoffeeReplView(state.atomCoffeeReplViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomCoffeeReplView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-coffee-repl:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomCoffeeReplView.destroy()

  serialize: ->
    atomCoffeeReplViewState: @atomCoffeeReplView.serialize()

  toggle: ->
    console.log 'AtomCoffeeRepl was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

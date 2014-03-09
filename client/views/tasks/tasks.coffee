
Template.home.searchItems = () -> Session.get 'searchItems'

Template.home.events
  'click .addSearchButton': (e) ->
    addSearchItem e
    
  'submit .addSearchForm': (e) ->
    addSearchItem e
  
  'click .deleteItemButton': (e) ->
    e.preventDefault()
    index = ($(e.target).data 'index')
    console.log "deleteItem: #{index}"
    items = Session.get 'searchItems'
    if items? and 0 <= index <= items?.length then items.splice index, 1
    items[index].index = index++ while index < items.length
    Session.set 'searchItems', items
      
    
addSearchItem = (e) ->
    e.preventDefault()
    type = $(e.target).data 'type'
    input = if type is 'file' then $ '#addSearchFile' else $ '#addSearchTerm'
    text = input.val()
    input.val ''
    text = text.substring 12 if type is 'file'
    console.log "add #{type} #{text}"
    if text? and text.length > 0
      items = Session.get('searchItems') ? []
      item = { index: items.length, type: type, text: text }
      # test array contents to see if new text is already in there..
      for currentItem in items
        if currentItem.text is text
          return
      items.push item
      Session.set 'searchItems', items
  
    


Template.taskItem.events

  'click .deleteItemButton': (e) ->
    e.preventDefault()
    index = ($(e.target).data 'index')
    console.log "deleteItem: #{index}"
    items = Session.get 'searchItems'
    if items? and 0 <= index <= items?.length then items.splice index, 1
    items[index].index = index++ while index < items.length
    Session.set 'searchItems', items
      

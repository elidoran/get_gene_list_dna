
Template.taskSubmit.events
  'click .addSearchButton': (e) ->
    addSearchItem e
    
  'submit .addSearchForm': (e) ->
    addSearchItem e

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


'submit form': (e) ->
    e.preventDefault();

    message = $(e.target).find('[name=message]').val()
    
    task =
      term: 'term'
    
    Meteor.call 'newTask', task, (error, id) ->
      if error then throwError error.reason


@Tasks = new Meteor.Collection('tasks')

Tasks.allow
  #update: ownsDocument
  #remove: ownsDocument

Tasks.deny
  update: -> true
#  update: (userId, task, fieldNames) ->
#    # may only edit the following field:
#    (_.without(fieldNames, 'archived').length > 0)
    
Meteor.methods
  newTask: (taskData, callback) ->
    
    user = Meteor.user()
    
    unless user # ensure the user is logged in
      throw new Meteor.Error 401, 'You need to login to post new tasks'

    # ensure the task has a term
    unless taskData.term
      throw new Meteor.Error 422, 'Provide search term'

    taskWithSameTerm = Tasks.findOne 
      userId: user._id
      term: taskData.term

    # check there are no previous tasks with the same term
    if taskWithSameTerm
      throw new Meteor.Error 302, 'Term has already been added',
          taskWithSameTerm._id

    task =
      userId: user._id
      author: user.profile.name
      submitted: new Date().getTime()
      term: taskData.term

    Tasks.insert task, (error, taskId) ->
      #console.log 'Tasks.insert'
      unless error?
        # search NCBI for IDs
        NCBI.search { term: taskData.term, filter: 'bacteria' }, (error, result) ->
          #console.log 'NCBI.search'
          # tell the user if there was an error
          if error
            throw new Meteor.Error 500, 
              "Unable to retrieve data for search: #{taskData.term}"
              
          # we succeeded, so, get the idlist, then:
          #   1. store the IDs in the task 
          #   2. and fetch the DNA for the IDs
          ids = result?.esearchresult?.idlist
          #console.log "ID list: #{ids}"
          
          unless ids and ids?.length > 0
            throw new Meteor.Error 500, 
              "Zero IDs were returned for search term: #{taskData.term}"
          
          idhash = {}
          idhash[id] = '' for id in ids
          
          unless ids
            throw new Meteor.Error 500, 
              "NCBI search for #{taskData.term} did not return the 
              ID list necessary to continue."
          
          Tasks.update taskId, { $set: { results: idhash } }, (error) ->
            #console.log 'Tasks.update with ID'
            if error
              throw new Meteor.Error 500, 
                "Failed to store ID result for search: #{taskData.term}"
            
            # this uses a closure trick due to loop variable issue in JS
            for id in ids
              ((theTaskId, dnaId, theTerm) ->
                NCBI.fetch { id: dnaId }, (error, result) ->
                  #console.log "NCBI.fetch id[#{dnaId}]"
                  if error
                    throw new Meteor.Error 500, 
                      "Unable to fetch DNA for ID[#{dnaId}] from term[#{theTerm}]"
                  
                  # we succeeded, so, store this DNA in the corresponding ID
                  # of the task
                  update = { $set: {}}
                  update.$set['results.' + dnaId] = result
                  #update.$set.results[dnaId] = result
  
                  Tasks.update theTaskId, update, (error) ->
                    #console.log "Tasks.update with DNA result dnaId[#{dnaId}] result[#{result}]"
                    if error
                      throw new Meteor.Error 500,
                        "Unable to store DNA for ID[#{dnaId}] from 
                        term[#{theTerm}]"
              )(taskId, id, taskData.term)
  
      #callback error, taskId
  
  archiveTask: (task) ->
    
    user = Meteor.user()
    
    unless user # ensure the user is logged in
      throw new Meteor.Error 401, 'You need to login to archive a task'

    if task?.archived?
      throw new Meteor.Error 422, 'Task is already archived'
    else
      update = 
        archived: new Date().getTime()
      console.log "archive task '#{task.term}' (#{task._id})"
      Tasks.update task._id, { $set: update }, (error) ->
        if error?
          console.log "#{key} = #{val}" for key,val of error
          throw new Meteor.Error 500, 'Unable to archive task'




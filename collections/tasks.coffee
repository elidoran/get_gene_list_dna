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
  newTask: (taskData) ->
    
    user = Meteor.user()
    
    unless user # ensure the user is logged in
      throw new Meteor.Error 401, 'You need to login to post new tasks'

    # ensure the task has a term or file
    unless taskData.term or taskData.file
      throw new Meteor.Error 422, 'Provide search term or file'

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
    
    task.term = taskData.term if taskData?.term?
    task.file = taskData.file if taskData?.file?
      
    Tasks.insert task
  
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




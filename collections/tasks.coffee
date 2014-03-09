@Tasks = new Meteor.Collection('tasks')

#Tasks.allow
  #update: ownsDocument
  #remove: ownsDocument

Tasks.deny
  update: -> true
  
Meteor.methods
  post: (taskData) ->
    
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
          termWithSameTerm._id

    task =
      userId: user._id
      author: user.profile.name
      submitted: new Date().getTime()
    
    task.term = taskData.term if taskData?.term?
    task.file = taskData.file if taskData?.file?
      
    Tasks.insert task


Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  #notFoundTemplate: 'notFound'
  
  waitOn: () ->
    [
      Meteor.subscribe 'tasks'
      #Meteor.subscribe('notifications')
    ]

Router.map () ->

  this.route 'tasks', { path: '/' }



Router.before requireLogin, { only: 'tasks' }
Router.before () -> Errors.clearSeen()


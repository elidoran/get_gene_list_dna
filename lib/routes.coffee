
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

requireLogin = (pause) ->
  unless Meteor.user()
    if Meteor.loggingIn()
      this.render this.loadingTemplate
    else
      this.render 'accessDenied'
    pause()

Router.before requireLogin, { only: 'tasks' }
Router.before () -> clearErrors()


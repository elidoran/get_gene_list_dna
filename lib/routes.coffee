
Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  #notFoundTemplate: 'notFound'
  
  waitOn: () ->
    [
      #Meteor.subscribe('posts')
      #Meteor.subscribe('notifications')
    ]

Router.map () ->

  this.route 'home', { path: '/' }

  this.route 'progress'



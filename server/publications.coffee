Meteor.publish 'tasks', () -> Tasks.find { userId: this.userId }


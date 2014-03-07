server = require './server'
router = require './server/router'
requestHandlers = require './server/requestHandlers'


handle =
  '/'       : requestHandlers.start
  '/start'  : requestHandlers.start
  '/upload' : requestHandlers.upload;
  '/show'   : requestHandlers.show;

server.start router.route, handle

var server = require("./server");
var router = require("./server/router");
var requestHandlers = require("./server/requestHandlers");

var handle = {}
handle["/"] = requestHandlers.start;
handle["/start"]= requestHandlers.start;
handle["/upload"]=requestHandlers.upload;
handle["/show"]=requestHandlers.show;

server.start(router.route, handle);
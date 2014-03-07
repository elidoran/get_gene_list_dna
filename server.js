var http = require("http"),
querystring = require("querystring"),
url = require("url"),
split = require("split"),
Transform = require("stream")._transform;

function start (route, handle) {
    function onRequest (request, response) {
	var postData = ""; 
	var gene_array = [];
	var pathname = url.parse(request.url).pathname;
	console.log("Request for "+ pathname + " recieved.");
	request.setEncoding("utf8");
	
	request.addListener("data", function (postDataChunk) {
	    gene_array = querystring.parse(postDataChunk).text.split('\n');
	    console.log("Recieved POST data chunk  '"+postDataChunk+ "'.");
	});
	
	request.addListener("end", function () {
	    route(handle, pathname, response, gene_array);
	});
	
    }
    
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start; 

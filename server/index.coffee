http = require 'http'
querystring = require 'querystring'
url = require 'url'
split = require 'split'
Transform = require 'stream' ._transform;

start = (route, handle) ->
    onRequest = (request, response) ->
	  postData = ""; 
	  gene_array = [];
	  pathname = url.parse request.url .pathname;
	  console.log "Request for #{pathname} recieved.");
	  request.setEncoding "utf8"
	
	request.addListener 'data', (postDataChunk) ->
	    gene_array = querystring.parse postDataChunk .text.split '\n'
	    console.log "Recieved POST data chunk  '#{postDataChunk}'.");

	request.addListener 'end', () ->
	    route handle, pathname, response, gene_array

    http.createServer onRequest .listen(8888, () ->
        console.log 'Server has started.'
    );

exports.start = start; 

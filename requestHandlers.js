var querystring = require("querystring"),
	fs = require("fs"),
	split = require("split"), 
	Transform = require("stream")._transform;

function start(response){
	console.log("Request handler 'start' was called.");
	var body = '<html>'+
	'<head>'+
	'<meta http-equiv="Content-Type" content="text/html; '+
	'charset=UTF-8"/>'+
	'</head>'+
	'<body>'+
	'<form action="/upload" method="post">'+
	'<textarea name="text" rows="20" cols="10"></textarea>'+
	'<input type="submit" value="Submit text" />'+
	'<p>Or</p>'+	
	'<form action="/upload" enctype="multipart/form-data" method="post">'+
	'<input type="file" name="upload">'+
	'<input type="submit" value="Upload file" />'+
	'</form>'+
	'</body>'+
	'</html>';
	response.writeHead(200, {"Content-Type": "text/html"});
	response.write(body);
	response.end();
}

function upload(response, gene_array){
    console.log("Request handler 'upload' was called.");
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write("<h2>You've sent: </h2>");
    response.write("<ul>");
    //+querystring.parse(postData).text
    for (var i = 0;i<gene_array.length;i++){
	response.write("<li>"+gene_array[i]+"</li>");
    }
    response.write("</ul>")
    response.end();
}

function show (response) {
	console.log("Request handler to 'show' was called");
	response.writeHead(200, {"Content-Type": "text/plain"});
	fs.createReadStream("/tmp/test.png").pipe(response);
}


exports.start = start;
exports.upload = upload;
exports.show = show;

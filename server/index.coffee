# use express to enhance our http server
express = require 'express'

# create web server, export it as well as make a local var
exports.app = app = express()

# add middleware to web server

# 1. produces a log statement for each request
app.use express.logger()

# 2. compress results
app.use express.compress()

# 3. does json, multipart, posts
app.use express.bodyParser { keepExtensions: true, uploadDir: __dirname + '/uploads' }

# 4. allows other methods when client can only do get/post
app.use express.methodOverride()

# 5. use Express's router
app.use app.router

# 6. server static files from our 'server/public' folder
app.use express.static __dirname + '/public'

# 7. error handler put last ...
app.use (err, req, res, next) ->
    console.error err.stack
    res.send 500, 'server error'


# apply routes to web server
require('./routes').addTo app

# export function to startup the web server 
exports.start = (host, port) ->

    # start server, report port from returned server to be sure of the port
    server = app.listen port, host, () -> 
        console.log "Server listening on port #{server.address().port}"

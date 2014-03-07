fs = require 'fs'   # used to create a Readable file stream

# export work with a readable name to call
exports.addTo = (app) ->
    
    # need a better name context, are we posting a list of nucleotides to search?
    app.post '/list', (req, res) ->
        
        # send a 200 status plain text response always...
        res.status 200
           .type 'text/plain'
           .write 'You sent: \n\n'
               
        # if submitted as a string of text
        if req.param('text')?
            res.end req.param 'text'

        # if submitted as a file upload
        else if req.files?.upload?
            fs.createReadStream req.files.upload.path
              .pipe res

        # just say nothing for now...
        else
          res.end 'Nothing??'

    # show DNA results (need to provide a narrowing field for which DNA results)
    app.get '/dna', (req, res) -> 
        res.sendfile '/tmp/test.png'  
    
    # let's put an image in a test folder, add it to the repo, and then i can 
    # have it too
            
    
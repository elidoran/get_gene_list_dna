
# check for port in environment variable, else use default
port = process.env.PORT ? 8888
host = process.env.HOST ? null

require('./server').start host, port

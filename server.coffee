
express = require "express"
pile = require "pile"
logClients = require "./clientlogger"

css = pile.createCSSManager()
js = pile.createJSManager()
app = express.createServer()

io = require('socket.io').listen app

js.bind app
css.bind app

app.configure "development", ->
  js.addFile __dirname + "/client/remotelogger.coffee"
  # js.addUrl "http://jsconsole.com/remote.js?86EF08C8-38F4-4CDA-8054-C29F18189221"
  js.liveUpdate css, io
  logClients io

app.configure  ->

  css.addFile __dirname + "/stylesheets/style.styl"

  js.addUrl "/socket.io/socket.io.js"
  js.addFile __dirname + "/client/vendor/jquery.js"
  js.addFile __dirname + "/client/vendor/underscore.js"
  js.addFile __dirname + "/client/vendor/underscore.string.js"
  js.addFile __dirname + "/client/vendor/backbone.js"

  js.addFile __dirname + "/client/helpers.coffee"
  js.addFile __dirname + "/client/drawers.coffee"
  js.addFile __dirname + "/client/main.coffee"


app.get "/", (req, res) ->
  res.render "index.jade"

app.listen 1337



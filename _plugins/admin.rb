require 'rubygems'
require 'webrick'
require 'json'
require_relative '../run'

server = WEBrick::HTTPServer.new :Port => 8000
#server.mount_proc '/admin' do |req, res|
#  run=Run.new()
#  puts req["test"]
#  result= run.add_post({})
#  res.body=result.to_json()
#end
server.mount('/', WEBrick::HTTPServlet::CGIHandler, '/')
trap('INT') { server.stop } # stop server with Ctrl-C
server.start



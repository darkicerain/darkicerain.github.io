require 'rubygems'
require 'webrick'

require_relative 'admin-servlet'

server = WEBrick::HTTPServer.new(:Port => 1234)
server.mount"/", AdminServlet

server.start



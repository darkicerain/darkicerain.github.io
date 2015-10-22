server = WEBrick::HTTPServer.new :Port => 1234

server.config.store( :CGIInterpreter, "#{WEBrick::HTTPServlet::CGIHandler::Ruby}")
server.mount "/", WEBrick::HTTPServlet::FileHandler , $cgi_dir
trap('INT') { server.stop }
server.start

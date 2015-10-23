
require 'cgi'
cgi = CGI.new
puts cgi.header
puts "<html><body>Hello Webrick</body></html>"

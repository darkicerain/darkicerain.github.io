class AdminServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)

  end
  def do_GET(request, response)
    response.status = 200
    response.content_type ="text/plain"
    response.body = "hello bilegou"
  end
end
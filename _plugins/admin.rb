require 'rubygems'

require 'pathname'
require 'webrick'
require_relative '../rb/admin-servlet'

def os_family
  case RUBY_PLATFORM
    when /ix/i, /ux/i, /gnu/i,
        /sysv/i, /solaris/i,
        /sunos/i, /bsd/i
      "unix"
    when /win/i, /ming/i
      "windows"
    else
      "other"
  end
end

server = WEBrick::HTTPServer.new(:Port => 1234)
server.mount"/", AdminServlet

sys=os_family()
if sys=="windows" then
  require 'win32/process'
  info = Process.create(
      :app_name         => "ruby ../rb/admin-windows.rb",
      :creation_flags   => Process::DETACHED_PROCESS,
      :process_inherit  => false,
      :thread_inherit   => true,
      :cwd              => File.dirname(__FILE__)
  )
  pid = info.process_id
  puts "Server detached with pid '#{pid}'.", "Run `kill -9 #{pid}' to stop the server."

  else if sys =="unix"
         pid = Process.fork { server.start }
         Process.detach(pid)
         puts "Server detached with pid '#{pid}'.", "Run `kill -9 #{pid}' to stop the server."
       end
end




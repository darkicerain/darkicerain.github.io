#!/usr/bin/ruby
require 'cgi'
require 'json'

require_relative '../manage/article'
cgi = CGI.new
test={"a"=>"1","b"=>"2"}

puts cgi.header

puts Article::search("aw")

#!/usr/bin/ruby
require 'cgi'
require 'json'
require 'yaml'


require_relative '../manage/article'
cgi = CGI.new


puts cgi.header
#测试代码
#Article::save("fucker fuck you ~","this is a big dog","program",nil)
#puts Article::delete("2015-10-26-this-is-a-big-dog")

#data = YAML.load_file("/www/darkicerain.github.io/_data/links.yml")
#data.each { |item| puts item['name'] }
#p data
#data.push({"name"=>"testnew","url"=>"/test/","external"=>false})
#File.open("/www/darkicerain.github.io/_data/links.yml", "wb") {|f| YAML.dump(data, f) }
#Category::add("post","推送",false)
#Category::delete("post")

arc = Article::search("a")
p Article::get_arc_info(arc[0]["path"])
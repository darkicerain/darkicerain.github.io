require_relative 'category'
require 'find'

class Article
  @@article=[]

  def self.get_all()
    @temp_art=[]
    Find.find(Category::get_path()) {  |path|
      if(/^.*\.md$/.match(path))
        @temp_art.push(path)
      end
    }
    return @temp_art
  end

  def self.get_arc_by_id(arc_id)
    all=get_all()
    all.each{|value|
      if(value.include?arc_id)
        return value
      end
    }
    return false
  end

  def self.search(str='')
    str.gsub!('i','\\\\i')
    art=get_all()

    art.each{|value|
    #/www/darkicerain.github.io/categories/program/_posts/2015-10-26-this-is-a-big-dog.md
      #match = Regexp.new("^(.*-)([a-zA-Z-]*"+str+".*)$").match(value)
      match=value.match("^.+\/categories\/([a-z]+)\/_posts\/([0-9-]+)-([a-zA-Z-]*"+str+"[a-zA-Z-]*)\.md$")
      #match=value.match("^(.*-)([a-zA-Z-]*"+str+".*)$")

      if(match)
        arc={}
        arc["cate"]=$1
        arc["path"]=value
        arc["date"]=$2
        title=$3.to_s()
        arc["title"]=$3.to_s().gsub("-"," ")
        #puts $1+"||"+$2+"||"+$3
        @@article.push(arc)
      end
    }
    return @@article
  end

  def self.arc_head(title=nil,tags=nil,published=nil,permalink=nil,layout=nil)
    head_tpl="---
layout: {layout}
title: {title}
permalink: {permalink}
published: {published}
tags: {tags}
date: {date}
---\r\n"
    if layout
      head_tpl.gsub!(/\{layout\}/,layout)
    else
      head_tpl.gsub!(/\{layout\}/,"post")
    end

    if title
      head_tpl.gsub!(/\{title\}/,title)
    else
      return false
    end

    if permalink
      head_tpl.gsub!(/\{permalink\}/,permalink)
    else
      head_tpl.gsub!(/\{permalink\}/,"")
    end

    if published
      head_tpl.gsub!(/\{published\}/,published)
    else
      head_tpl.gsub!(/\{published\}/,"true")
    end

    if tags
      head_tpl.gsub!(/\{tags\}/,tags)
    else
      head_tpl.gsub!(/\{tags\}/,"")
    end

    head_tpl.gsub!(/\{date\}/,Time.new.inspect)
    return head_tpl
  end

  def self.save(content=nil,title=nil,cate=nil,des=nil,old_file=nil)

    if(cate==nil)
      return "no category"
    end

    if(title==nil)
      return "no title"
    end
    content=arc_head(title)+content
    new_file=Time.new.strftime("%Y-%m-%d")+"-"+title.gsub!(/[\s]+/,'-')+".md"

    #p Category::get_file_path(new_file,cate)

    if(old_file==nil)

      if !File::directory?Category::get_file_path(new_file,cate)
        #Category::add(cate)
        return -2
      end

      File.open(Category::get_file_path(new_file,cate), "w+") do |file|
        if file
          file.syswrite(content)
        else
          return -1
        end
      end
    else
      old=get_arc_by_id(old_file)
      if old
        File.open(old) do |file|
          if file
            file.syswrite(content)
            File.rename(old,Category::get_file_path(new_file,cate))

          else
            return false
          end
        end
      else
        return false
      end
    end
  end

  def self.delete(file_id)
    File.delete(get_arc_by_id(file_id))
  end

end
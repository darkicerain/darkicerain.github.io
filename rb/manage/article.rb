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

  def self.search(str='')
    str.sub!('i','\\\\i')
    art=get_all()
    art.each{|value|
      if(Regexp.new("^.*-[a-zA-Z-]*"+str+".*$").match(value))
        @@article.push(value)
      end
    }
    return @@article
  end

  def self.save(content=nil,title=nil,cate=nil,old_file=nil)
    if(cate=nil)
      return "no category"
    end
    if(title=nil)
      return "no title"
    end
    if(old_file==nil)

    else

    end
  end

  def self.delete(file_id)

  end

end
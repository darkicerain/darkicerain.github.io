require 'fileutils'
require 'yaml'

class Category
  @@cat_path='/www/darkicerain.github.io/categories'
  @@link_path='/www/darkicerain.github.io/_data/links.yml'
  def self.get_path()
    return @@cat_path
  end

  def self.get_file_path(new_file,cate)
    return get_path()+"/"+cate+"/_posts/"+new_file
  end

  def self.add(cate=nil,name='',external=false)
    if(cate)
      if File.directory?@@cat_path+'/'+cate+"/_posts"
        #return "exist"
        return -1
      else
        FileUtils.mkdir_p @@cat_path+'/'+cate+"/_posts"
        data = YAML.load_file(@@link_path)
        data.push({"name"=>name,"url"=>"/"+cate,"external"=>external})
        File.open(@@link_path, "wb") {|f| YAML.dump(data, f) }
        return true
      end
    else
      return -2
    end
  end

  def self.get()
    return Dir::entries(@@cat_path)
  end

  def self.delete(cate=nil)
    if(cate)
      data = YAML.load_file(@@link_path)
      data.each { |item|
        if item['url']=='/'+cate
            data.delete(item)
        end
      }
      File.open(@@link_path, "wb") {|f| YAML.dump(data, f) }
      return FileUtils::rm_rf(@@cat_path+'/'+cate);
    else
      return -2
    end
  end
end
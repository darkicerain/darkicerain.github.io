require 'fileutils'

class Category
  @@cat_path='/www/darkicerain.github.io/categories'
  def self.get_path()
    return @@cat_path
  end
  def self.add(cate=nil)
    if(cate)
      if File.directory?@@cat_path+'/'+cate
        return "exist"
      else
        Dir::mkdir @@cat_path+'/'+cate
        return "success"
      end
    else
      "no param"
    end
  end
  def self.get()
    return Dir::entries(@@cat_path)
  end
  def self.delete(cate=nil)
    if(cate)
      return FileUtils::rm_rf(@@cat_path+'/'+cate);
    else
      return "no param"
    end
  end
end
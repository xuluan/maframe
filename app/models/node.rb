
def gen_node(file)
  path = File.absolute_path(file)
  name = File.basename(file)
  type = File.directory?(path) ? :dir : :file
  root = {name: name, path: path, type: type, tree: []}

  Dir.glob("#{path}/*") { |file|  root[:tree].push(gen_node(file)) } if type == :dir

  root
end

class Node < ActiveRecord::Base
  attr_accessible :name, :path, :prj, :tree, :type

  def Node.from_prj(prj)
    return nil unless prj

    root = gen_node(prj.path)
    root[:prj] = prj.name
    [root]
  end

  def Node.rm(path, prj)
    #TODO check path is valid!!!
    system("rm -rf #{path}")
  end

  def Node.mkdir(path, prj)
    #TODO check path is valid!!!
    system("mkdir -p #{path}")
  end
end



class Project < ActiveRecord::Base
  PRJ_HOME = "prj"

  attr_accessible :name, :path

  before_create :dir_create

  before_destroy :dir_destroy


  def dir_create
    Dir.mkdir(PRJ_HOME) unless Dir.exist?(PRJ_HOME)
    prj_dir = "#{PRJ_HOME}/#{self.name}"
    #TODO dir exist or mkdir fail
    Dir.mkdir(prj_dir)
    self.path = File.absolute_path(prj_dir)
  end

  def dir_destroy

    prj_dir = "#{PRJ_HOME}/#{self.name}"
    system("rm #{prj_dir} -rf")    
  end
end

class Node < ActiveRecord::Base
  attr_accessible :name, :path, :prj, :tree, :type
end

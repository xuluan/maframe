class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :tree
      t.string :path
      t.string :type
      t.string :prj

      t.timestamps
    end
  end
end

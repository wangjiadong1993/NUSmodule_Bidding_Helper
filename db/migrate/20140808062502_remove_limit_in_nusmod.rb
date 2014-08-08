class RemoveLimitInNusmod < ActiveRecord::Migration
  def change
  	change_column :nusmods, :department_id, :integer, :limit => nil
  end
end

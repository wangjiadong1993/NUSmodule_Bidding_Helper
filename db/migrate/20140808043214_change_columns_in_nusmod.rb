class ChangeColumnsInNusmod < ActiveRecord::Migration
  def change
  	rename_column :preclulinks, :exlude_id, :exclude_id
  	add_column :nusmods, :modulecredit, :integer
  end
end

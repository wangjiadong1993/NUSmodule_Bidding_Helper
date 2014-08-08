class ChangeColumnOfNusmod < ActiveRecord::Migration
  def change
  	rename_column :nusmods, :department, :department_id
  	change_column :nusmods, :department_id, :integer
  end
end

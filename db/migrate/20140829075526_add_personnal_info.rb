class AddPersonnalInfo < ActiveRecord::Migration
  def change
	  add_column :users, :general_point, :integer, default: 0
	  add_column :users, :program_point, :integer, default: 0
  end
end

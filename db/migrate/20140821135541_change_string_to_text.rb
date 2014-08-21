class ChangeStringToText < ActiveRecord::Migration
  def change
	  change_column :nusmods, :description, :text
  end
end

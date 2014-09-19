class Changeclassno < ActiveRecord::Migration
  def change
	  change_column :modtimes, :classnum, :string
  end
end

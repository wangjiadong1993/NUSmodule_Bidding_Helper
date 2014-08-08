class CreateIvles < ActiveRecord::Migration
  def change
    create_table :ivles do |t|
      
      t.timestamps
    end
  end
end

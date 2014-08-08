class CreatePreclulinks < ActiveRecord::Migration
  def change
    create_table :preclulinks do |t|
      t.integer :module_id
      t.integer :exlude_id
      t.timestamps
    end
  end
end

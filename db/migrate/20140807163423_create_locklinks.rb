class CreateLocklinks < ActiveRecord::Migration
  def change
    create_table :locklinks do |t|
      t.integer :module_id
      t.integer :locked_id
      t.timestamps
    end
  end
end

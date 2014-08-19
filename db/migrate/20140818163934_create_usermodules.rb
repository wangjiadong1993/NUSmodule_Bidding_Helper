class CreateUsermodules < ActiveRecord::Migration
  def change
    create_table :usermodules do |t|
    	t.integer :nusmod_id
    	t.integer :user_id
    	t.integer :status
      	t.timestamps
    end
  end
end

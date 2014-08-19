class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :startyear
      t.integer :department_id
      t.timestamps
    end
  end
end

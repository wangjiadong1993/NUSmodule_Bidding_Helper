class CreateNusmods < ActiveRecord::Migration
  def change
    create_table :nusmods do |t|
      t.string :name
      t.string :code
      t.string :description
      t.string :workload
      t.string :department
      t.string :academicyear
      t.string :moduletype
      t.integer :ivle_id
      t.timestamps
    end
  end
end

class CreateModhis < ActiveRecord::Migration
  def change
    create_table :modhists do |t|
      t.datetime :examtime
      t.integer :semester
      t.integer :nusmod_id
      t.timestamps
    end
  end
end

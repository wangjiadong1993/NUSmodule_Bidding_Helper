class CreateModtimes < ActiveRecord::Migration
  def change
    create_table :modtimes do |t|
      t.integer :nusmod_id
      t.integer :classnum
      t.string :LessonType
      t.integer :weekcode
      t.string :weektext
      t.integer :daycode
      t.string :daytext
      t.integer :endtime
      t.integer :starttime
      t.string :venue
      t.string :academicyear
      t.integer :semester
      t.boolean :deleflag
      t.timestamps
    end
  end
end

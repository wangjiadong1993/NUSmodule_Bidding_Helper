class RenameColumnInModtime < ActiveRecord::Migration
  def change
  	rename_column :modtimes, :LessonType, :lessontype
  end
end

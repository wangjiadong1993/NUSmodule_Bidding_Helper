class Nusmod < ActiveRecord::Base
	has_many :locklinks, foreign_key: :module_id
	has_many :prelinks, class_name: "Locklink", foreign_key: :locked_id

	has_many :lockmodules, through: :locklinks, class_name: "Nusmod"
	has_many :nusmods, through: :prelinks

	# nusmod has many lockmodules, has many nusmods(prerequisit modules)

	has_many :preclulinks, foreign_key: :module_id
	has_many :cludemodules, through: :preclulinks, class_name: "Nusmod"
end

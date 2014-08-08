require 'net/http'
class Nusmod < ActiveRecord::Base
	
	belongs_to :department

	has_many :locklinks, foreign_key: :module_id
	has_many :prelinks, class_name: "Locklink", foreign_key: :locked_id

	has_many :lockmodules, through: :locklinks, class_name: "Nusmod"
	has_many :nusmods, through: :prelinks

	# nusmod has many lockmodules, has many nusmods(prerequisit modules)

	has_many :preclulinks, foreign_key: :module_id
	has_many :cludemodules, through: :preclulinks, class_name: "Nusmod"



	def self.modimport
		ur = URI("http://api.nusmods.com/2014-2015/moduleInformation.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |module|
			dep_d = Department.find_by_name(module['Department'])
		end
	end
end

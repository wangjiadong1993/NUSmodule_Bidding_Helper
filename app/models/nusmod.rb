require 'net/http'
class Nusmod < ActiveRecord::Base
	include Elasticsearch::Model
	has_many :locklinks, foreign_key: :module_id
	has_many :prelinks, class_name: "Locklink", foreign_key: :locked_id

	has_many :lockmodules, through: :locklinks, class_name: "Nusmod"
	has_many :nusmods, through: :prelinks

	# nusmod has many lockmodules, has many nusmods(prerequisit modules)

	has_many :preclulinks, foreign_key: :module_id
	has_many :cludemodules, through: :preclulinks, class_name: "Nusmod";

	belongs_to :department

	has_many :modhists

	has_many :biddings

	has_many :modtimes

	mappings do 
		indexes :name, type: "string", index: "not_analyzed"
		indexes :code, type: "string", index: "not_analyzed"
	end





	def self.modimport
		ur = URI("http://api.nusmods.com/2014-2015/moduleInformation.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |modu|
			dep_d = Department.find_by_name(modu['Department'])
			if !(dep_d.nil? || modu['Department'].include?('Registrar'))
				mod_d = dep_d.nusmods.build(name: modu['ModuleTitle'], code: modu['ModuleCode'], description: modu['ModuleDescription'], modulecredit: modu['ModuleCredit'],workload: modu['Workload'])
				mod_d.save!
			end
		end
	end

	def self.fast key_word
		response = Nusmod.search  key_word
		response = response.results.map{|x| x.name}.to_a
	end







	def self.import_all
		Faculty.falimport
		Department.depimport
		Nusmod.modimport
	end
end

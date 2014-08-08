class Modhist < ActiveRecord::Base
	belongs_to :nusmod

	def self.histimport
		ur = URI("http://api.nusmods.com/2014-2015/moduleInformation.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |modu|
			dep_d = Department.find_by_name(modu['Department'])
			if !(dep_d.nil? || modu['Department'].include?('Registrar'))
				mod_d = Nusmod.find_by_code(modu['ModuleCode'])
				if !mod_d.nil?
					if !modu['History'].empty?
						modu['History'].each do |m|
							his_d = mod_d.modhists.build(semester: m['Semester'], examtime: m['ExamDate'])
							his_d.save!
						end
					end
				end
			end
		end 
	end
end

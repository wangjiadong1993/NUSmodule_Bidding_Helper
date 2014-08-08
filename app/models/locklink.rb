class Locklink < ActiveRecord::Base
	belongs_to :nusmod, foreign_key: :module_id
	belongs_to :lockmodule, class_name: "Nusmod", foreign_key: :locked_id
	def self.lockimport
		ur = URI("http://api.nusmods.com/2014-2015/modules.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |mod|
			mod_d = Nusmod.find_by_code(mod['ModuleCode'])
			if(!mod['LockedModules'].nil?)
				if (!mod['LockedModules'].empty?) && (!mod_d.nil?) 
					mod['LockedModules'].each do |b|
						c  = Nusmod.find_by_code(b)
						if c.nil?
						 	# d = mod_d.locklinks.build(remarks: b)
						 	# d.save!
						else
							d = mod_d.locklinks.build(locked_id: c.id)
							d.save!
						end
						# c = b.scan(/[a-zA-Z]{1,3}\d{3,5}[a-zA-Z]{0,2}/)
						# if c.nil?
						# elsif c.empty?
						# elsif c[0]!=b
						# 	d = mod_d.locklinks.build(remarks: b)
						# 	d.save!
						# else

						# end
					end
				end
			end
		end
	end
end

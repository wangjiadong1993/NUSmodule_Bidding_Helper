class Modtime < ActiveRecord::Base
	belongs_to :Nusmod

	def self.modtimimport
		ur = URI("http://api.nusmods.com/moduleTimetableDeltaRaw.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |mod|
			mod_d = Nusmod.find_by_code(mod['ModuleCode'])
			if mod_d.nil?

			else
				modtime_d = mod_d.modtimes.build(classnum: mod['ClassNo'], lessontype: mod['LessonType'], weekcode:mod['WeekCode'],weektext:mod['WeekText'],daycode:mod['DayCode'],daytext:mod['DayText'],endtime:mod['EndTime'],starttime:mod['StartTime'],venue:mod['Venue'],academicyear:mod['AcadYear'],semester:mod['Semester'],deleflag:mod['isDelete'])
				modtime_d.save
			end
		end
	end
end

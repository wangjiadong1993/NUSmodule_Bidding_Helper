class Modtime < ActiveRecord::Base
	belongs_to :Nusmod
	scope :real, -> { where(deleflag: nil) } 
	scope :sem2, -> { where(semester: 2 )} 
	scope :sem1, -> { where(semester: 1)}
	scope :lesson, ->(lectype) {where("LessonType = ?", lectype)}
	##not using anymore

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


	def self.modtimimport2
		mods = JSON.parse(IO.read("/Users/wangjiadong/Downloads/modules.json"))
		mods.each do |mod|
			mod_d = Nusmod.find_by_code(mod['ModuleCode'])
			if mod_d.nil?

			else
				mod['History'].each do |obj|
					if obj['Timetable']!=nil
						if !obj['Timetable'].empty?
							obj['Timetable'].each do |time_j|
								modtime_d = mod_d.modtimes.build(classnum: time_j['ClassNo'], lessontype: time_j['LessonType'],weektext:time_j['WeekText'],daytext:time_j['DayText'],endtime:time_j['EndTime'],starttime:time_j['StartTime'],venue:time_j['Venue'],academicyear:"2014/2015",semester:obj['Semester'], deleflag: nil)
								modtime_d.save
							end
						end
					end
				end
			end

		end
	end

	def self.modselect arr
		if arr.class.to_s != 'Array' 
			return 
		end

		len = arr.length

		if len == 1
			brr = arr[0].modtimes
		end

		for i in 0..len-1

		end
	end
end

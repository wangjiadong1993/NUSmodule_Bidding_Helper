require 'net/http'
class Faculty < ActiveRecord::Base
	has_many :departments

	def self.falimport
		ur = URI("http://api.nusmods.com/2014-2015/1/facultyDepartments.json")
		fal = Net::HTTP.get(ur)
		fal = JSON.parse(fal).keys
		# fal = fal.keys
		fal.each do |f| 
			faculty = Faculty.new(name: f.to_s)
			faculty.save!
		end
	end
end

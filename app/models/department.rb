require 'net/http'
class Department < ActiveRecord::Base
	belongs_to :faculty

	def self.depimport
		ur = URI("http://api.nusmods.com/2014-2015/1/facultyDepartments.json")
		dep = Net::HTTP.get(ur)
		dep = JSON.parse(dep)
		dep.each do |d|
			f = Faculty.find_by_name(d[0])
			d[1].each do |de|
				department = f.departments.build(name: de)
				department.save!
			end
		end

	end
end

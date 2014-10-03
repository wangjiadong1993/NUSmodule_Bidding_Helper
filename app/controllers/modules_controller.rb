
class ModulesController < ApplicationController
	def index
		response={}
		response[:modules]=Nusmod.all.as_json(only: [:code])
		render json: response, status: 200
	end
	def mod_info
		response={}
		@module = Nusmod.find_by_id(params[:id])
		puts @module.attributes
		if @module.nil? || params[:id].nil?
			response[:status]=0
			response[:error_msg]="Module not found"
		else
			response[:status]=1
			response[:module]=@module.as_json(except: [:created_at, :updated_at])
			response[:department]=@module.department.as_json(except: [:created_at, :updated_at, :faculty_id])
			response[:faculty]=@module.department.faculty.as_json(except: [:created_at, :updated_at])
			response[:times]=@module.modtimes.real.sem1.as_json(except: [:nusmod_id, :weekcode, :daycode, :academicyear,:deleflag,:classnum,:id, :created_at, :updated_at])
			response[:locklinks]=@module.locklinks
			response[:preclulinks]=@module.preclulinks

		end
		render json: response, status: 200
	end
	def code_info
		response={}
		@module = Nusmod.find_by_code(params[:id])
		if @module.nil? || params[:id].nil?
			response[:status]=0
			response[:error_msg]="Module not found"
		else
			response[:status]=1
			response[:module]=@module.as_json(except: [:created_at, :updated_at])
			response[:department]=@module.department.as_json(except: [:created_at, :updated_at, :faculty_id])
			response[:faculty]=@module.department.faculty.as_json(except: [:created_at, :updated_at])
			# response[:times]=@module.modtimes.real.sem1.as_json(except: [:nusmod_id, :weekcode, :daycode, :academicyear,:deleflag,:id, :created_at, :updated_at])
			@modtimes = @module.modtimes.real.sem1
			labels = @modtimes.map(&:classnum).uniq
			# group_label = []
			# modtimes.each {|x| group_label[labels.index(x.classnum)].nil? ? group_label[labels.index(x.classnum)]=[x] : group_label[labels.index(x.classnum)]<< x} unless (modtimes.nil? || modtimes.empty?)
			# response[:groups] = group_label
			response[:lectures]=@modtimes.where(lessontype: "Lecture").group_by(&:classnum)
			response[:tutorials]=@modtimes.where(lessontype: "Tutorial").group_by(&:classnum)
			response[:package]=@modtimes.where(lessontype: ["Packaged Tutorial","Packaged Lecture"]).group_by(&:classnum)
			# response[:packed_lectures]=@modtimes.where(lessontype: "Packaged Lecture").group_by(&:classnum)
			# response[:p]
			response[:sectional]=@modtimes.where(lessontype: "Sectional Teaching").group_by(&:classnum)
			response[:design]=@modtimes.where(lessontype: "Design Lecture").group_by(&:classnum)
			response[:seminar]=@modtimes.where(lessontype: "Seminar-Style Module Class").group_by(&:classnum)
			response[:lab]=@modtimes.where(lessontype: "Laboratory").group_by(&:classnum)
			response[:recitation]=@modtimes.where(lessontype: "Recitation").group_by(&:classnum)
			response[:tutorial_2]=@modtimes.where(lessontype: "Tutorial Type 2").group_by(&:classnum)
			response[:tutorial_3]=@modtimes.where(lessontype: "Tutorial Type 3").group_by(&:classnum)
			# response[:group] = seperate response[:times]
			# response[:lectures] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
			# response[:tutorials] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
			# response[:labs] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
			# response[:packedlecs] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
			# response[:packedtuts] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
########		response[:lectures] = @module.modtimes.real.sem1.where(lessontype: "Lecture")
########		response[:lectures] = @module.modtimes.real.sem1.where(lessontype: "Lecture")

			response[:locklinks]=@module.locklinks
			response[:preclulinks]=@module.preclulinks

		end
		render json: response, status: 200	
	end
	def personal_info
		response={}
		http_status = 200

		@username = params[:username]
		@password = params[:password]
		temp_arr= User.get_point @username, @password
		response[:general_point]=temp_arr[0]
		response[:program_point]=temp_arr[1]
		render json: response, status: http_status
	end

	private
	def seperate times
		# groups = []
		# labels = times.map(&:classnum).uniq
	end
end

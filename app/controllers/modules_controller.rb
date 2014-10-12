
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

			@modtimes_group = @modtimes.group_by(&:classnum)
			@modtimes_group_group = @modtimes_group.values.group_by{|x| x.first.lessontype}.values
			#response[:modtimes_group_group] = @modtimes_group_group.values
			@modtimes_group_group.each do |x|
				if x !=  @modtimes_group_group[0]
					@modtimes_group_group[0] = x.product @modtimes_group_group[0]
				end
			end
			response[:combination] = @modtimes_group_group[0].map{|x| x.flatten}# x.map{|y| y.as_json(except: [:created_at, :updated_at, :id, :nusmod_id, :weekcode, :daycode, :academicyear, :deleflag, :semester])}}
			# group_label = []
			# modtimes.each {|x| group_label[labels.index(x.classnum)].nil? ? group_label[labels.index(x.classnum)]=[x] : group_label[labels.index(x.classnum)]<< x} unless (modtimes.nil? || modtimes.empty?)
			# response[:groups] = group_label
			# response_a = {}
			# response[:lectures]=@modtimes.where(lessontype: "Lecture").group_by(&:classnum)
			# response[:tutorials]=@modtimes.where(lessontype: "Tutorial").group_by(&:classnum)
			# response[:package]=@modtimes.where(lessontype: ["Packaged Tutorial","Packaged Lecture"]).group_by(&:classnum)
			# response[:sectional]=@modtimes.where(lessontype: "Sectional Teaching").group_by(&:classnum)
			# response[:design]=@modtimes.where(lessontype: "Design Lecture").group_by(&:classnum)
			# response[:seminar]=@modtimes.where(lessontype: "Seminar-Style Module Class").group_by(&:classnum)
			# response[:lab]=@modtimes.where(lessontype: "Laboratory").group_by(&:classnum)
			# response[:recitation]=@modtimes.where(lessontype: "Recitation").group_by(&:classnum)
			# response[:tutorial_2]=@modtimes.where(lessontype: "Tutorial Type 2").group_by(&:classnum)
			# response[:tutorial_3]=@modtimes.where(lessontype: "Tutorial Type 3").group_by(&:classnum)
			
			# arrs1 = [response[:lectures], response[:tutorials], response[:package], response[:sectional], response[:design], response[:seminar],response[:lab], response[:recitation], response[:tutorial_2],response[:tutorial_3]]
			# arrs = arrs1.map{|x| x.values}
			# tmp = arrs1.reject{|x| x.values.empty?}
			# response[:keys] = tmp
			# arrs = arrs.reject {|x| x.empty?}
			# arrs = arrs.map{|x| x.map(&:lessontype)}
			# if !arrs.empty?
			# 	brr = [arrs[0]]
			# 	if !arrs[1].nil?
			# 		arrs[(1..arrs.length)].each do |x|
			# 			brr.product(x)
			# 		end
			# 	end
			# end
			# response[:combination] = brr
			 # times.group_by(&:lessontype).values.map {|y| y.map(&:classnum).uniq}
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
	def new
		@mod = Nusmod.new
	end
	def create

	end
	private
	def seperate times
		# groups = []
		# labels = times.map(&:classnum).uniq
	end
end

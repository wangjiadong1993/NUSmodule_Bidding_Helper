
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

end

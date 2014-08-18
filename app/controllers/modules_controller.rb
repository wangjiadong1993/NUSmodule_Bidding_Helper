
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
			response[:module]=@module
			response[:department]=@module.department
			response[:faculty]=@module.department.faculty
			response[:times]=@module.modtimes
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
		doc = Nokogiri::HTML(open("http://www.google.com.sg"))
		response[:page]=get_point @username, @password
		render json: response, status: http_status
	end

end

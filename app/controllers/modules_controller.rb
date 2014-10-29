
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
		@modtimes = @module.modtimes.real.sem1 unless @module.nil?

		if @module.nil? || params[:id].nil?
			response[:status]=0
			response[:error_msg]="Module not found"
		elsif @modtimes.nil? || @modtimes.empty?
			response[:status]=0
			response[:error_msg]="modules not offered this semester"
			# render json: response, http_status: 404
		else
			response[:status]=1
			response[:module]=@module.as_json(except: [:created_at, :updated_at])
			response[:department]=@module.department.as_json(except: [:created_at, :updated_at, :faculty_id])
			response[:faculty]=@module.department.faculty.as_json(except: [:created_at, :updated_at])
			# @modtimes.group_by(&:lessontype).values.each do |x|
			# 	if x.count >1 
			# 		x.each do |y|
			# 			x[0...x.index(y)].each do |z|
			# 				if y.starttime == z.starttime && y.daycode == z.daycode
			# 					@modtimes.delete(y)
			# 				end
			# 			end
			# 		end
			# 	end
			# end
			# response[:count] = @modtimes.count
			# @modtimes.group_by(&:lessontype)
			@modtimes_group = @modtimes.group_by(&:classnum)
			@modtimes_group_group = @modtimes_group.values.group_by{|x| x.first.lessontype}.values #unless @modtimes_group.values.nil?
			# response[:group_class] = @modtimes_group
			# response[:group_group_prev] = @modtimes_group_group.map{|x| x.map {|y| y.count}.inject(:+)}.inject(:+)
			# @modtimes_group_group.each do |z|
			# 	if  z.length > 1
			# 		if z.first.size ==1
			# 			z.each do |y|
			# 				z[(0...z.index(y))].each do |x|
			# 					if y[0].starttime == x[0].starttime && y[0].daytext == x[0].daytext
			# 						z.delete y
			# 					end
			# 				end
			# 			end
			# 		end
			# 	end
			# end
			# response[:group_group_later] = @modtimes_group_group.map{|x| x.map {|y| y.count}.inject(:+)}.inject(:+)
			@modtimes_group_group.each do |x|
				if x !=  @modtimes_group_group[0]
					@modtimes_group_group[0] = x.product @modtimes_group_group[0]
				end
			end
			response[:combination] = @modtimes_group_group[0].map{|x| x.flatten} #unless @modtimes_group_group[0].nil?# x.map{|y| y.as_json(except: [:created_at, :updated_at, :id, :nusmod_id, :weekcode, :daycode, :academicyear, :deleflag, :semester])}}
			# response[:locklinks]=@module.locklinks
			# response[:preclulinks]=@module.preclulinks

		end
		render json: response, status: 200	
	end
	def fast_search
		response = {}
		http_status = 200

		response[:chcoices] = Nusmod.fast params[:key_word]
		

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

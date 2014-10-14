class BidController < ApplicationController
	def show
			
	end
	def show_code
		@module = Nusmod.find_by_code(params[:code])
		response = {}
		http_status = 200
		if @module.nil? || params[:code].nil?
			response[:status] = 0
			response[:error_msg]  = "Record not found"
			http_status = 404
		end

		@biddings = @module.biddings
		response[:biddings] = @biddings
		response[:status] = 1
		render json: response, status: http_status
	end

end

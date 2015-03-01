class LocationsController < ApplicationController
	def index
		@locations = Location.all
		response = {}
		response[:status] = 1
		response[:locations] = @locations
		render json: response, status: 200		
	end

	def show
		
	end

	def create
		@location  = Location.new
		@lat = param[:latitude]
		@lon = param[:longitude]
		@location.latitude = @lat
		@location.longitude = @lon
		response = {}
		response[:status] = 1
		if(!@lat.nil? && !@lon.nil? && @location.save)
			response[:location] = @location
		else
			response[:status] = 0
			response[:location] = nil
		end
		render json: response, status: 201

	end

	def update
	end

	def delete
	end

	def latest
		@location = Location.last
		respoinse = {}
		response[:status] = 1
		response{:location} = @location
		render json: response, status:200
	end
end

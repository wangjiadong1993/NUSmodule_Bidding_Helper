class ModimpController < ApplicationController
	def faculty
		response={}
		response[:msg]="hello world"
		render json: response, status: 200
	end
end

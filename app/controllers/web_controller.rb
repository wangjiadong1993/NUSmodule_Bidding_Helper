class WebController < ApplicationController
	def modules
		render "modules", layout: false
	end
end

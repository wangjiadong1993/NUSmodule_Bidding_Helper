class User < ActiveRecord::Base 


		def self.get_point userid, passwd
		login_page =nil
		agent = Mechanize.new
		#  Mechanize.new do |agent| 
		# 	agent.get("https://myaces.nus.edu.sg/cors/StudentLogin") do |login_page|
		# 		login_page.form_with(action: "StudentLogin") do |login_form|
		# 			login_form.field_with(name: USERID).value = userid
		# 			login_form.field_with(name: PASSWORD).value = passwd
		# 		end
		# 	end
		# 	page = agent.submit
		# end
		# page.content
	end
end

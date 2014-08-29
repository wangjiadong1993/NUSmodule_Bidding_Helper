class User < ActiveRecord::Base 


	def self.get_point userid, passwd
		login_page =nil
		# agent = Mechanize.new
		agent = Mechanize.new
		login_page = agent.get("https://myaces.nus.edu.sg/cors/StudentLogin")
		login_form = login_page.form_with(action: "StudentLogin")
		login_form.field_with(name: "USERID").value = userid
		login_form.field_with(name: "PASSWORD").value = passwd
		page = login_form.submit
		page = page.link_with(text: "NUS Point \r\n              Management").click
		g_point =page.search("tr.tableheader")[1].search("td")[2].content.to_s.scan(/\d+/)[0]
		form = page.form
		form.fields[4].value = form.fields[4].options[1]
		page = form.submit
		p_point = page.search("tr.tableheader")[1].search("td")[2].content.to_s.scan(/\d+/)[0]
		arr = [g_point, p_point]
	
	end

	def get_modules 
		agent = Mechanize.new
		login_page = agent.get("https://www.eng9.nus.edu.sg/degree/login.html")
		login_form = login_page.form
		login_form.field_with(name: "userid").value = self.username
		login_form.field_with(name: "pwd").value = self.password
		main = login_form.submit
		####get requirement first
		req = main.link_with(text: "Major Requirements").click
		doc = Nokogiri::HTML(req)
		modules = []
		doc.xpath('//td[@class="tdcell"]').each {|x| modules << x.text.gsub(/\s+/,"")}
		modules = modules.slice(20, modules.size-5)
	end

end

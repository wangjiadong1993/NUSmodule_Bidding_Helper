class Bidding < ActiveRecord::Base
	belongs_to :nusmod

	def self.bidimport
		ur = URI("http://api.nusmods.com/2014-2015/modules.json")
		mods = Net::HTTP.get(ur)
		mods = JSON.parse(mods)
		mods.each do |mod|
			mod_d = Nusmod.find_by_code(mod['ModuleCode'])
			if(!mod['CorsBiddingStats'].nil?)
				if (!mod['CorsBiddingStats'].empty?) && (!mod_d.nil?) 
					mod['CorsBiddingStats'].each do |b|
						bid_d = mod_d.biddings.build(academicyear:b['AcadYear'].scan(/\d+/)[0], lowestsuccess:b['LowestSuccessfulBid'],lowestbid:b['LowestBid'],highestbid:b['HighestBid'],accounttype:b['StudentAcctType'],round:b['Round'],bidder:b['Bidders'],quota:b['Quota'])
						bid_d.save!
					end
				end
			end
		end
	end
end

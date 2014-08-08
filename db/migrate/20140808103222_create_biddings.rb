class CreateBiddings < ActiveRecord::Migration
  def change
    create_table :biddings do |t|
        t.integer  "academicyear"
	    t.integer  "nusmod_id"
	    t.integer  "lowestsuccess"
	    t.integer  "lowestbid"
	    t.integer  "highestbid"
	    t.string   "accounttype"
	    t.string   "round"
	    t.integer  "bidder"
	    t.integer  "quota"
        t.timestamps
    end
  end
end

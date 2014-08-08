class Preclulink < ActiveRecord::Base
		belongs_to :nusmod, foreign_key: :module_id
		belongs_to :cludemodule, class_name: "Nusmod",foreign_key: :exlude_id
	    # belongs_to :cludemodule, class_name: "Nusmod", foreign_key: :exclude_id
end

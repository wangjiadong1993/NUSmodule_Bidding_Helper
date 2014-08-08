class Locklink < ActiveRecord::Base
	belongs_to :nusmod, foreign_key: :module_id
	belongs_to :lockmodule, class_name: "Nusmod", foreign_key: :locked_id
end

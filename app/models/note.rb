class Note < ActiveRecord::Base
	#belongs_to:user

	has_and_belongs_to_many :users #append this line to your model
end

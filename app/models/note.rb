class Note < ActiveRecord::Base
	#belongs_to:user

	#after_create add_author_permission
	has_and_belongs_to_many :users #append this line to your model

	# Get the user who originally created a note
  	def get_author
    	User.find(author_id)
  	end

  	# Return notes where the note's description contains a word in the search query
	def self.search(search)
	  if search
	    where('description LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end


end

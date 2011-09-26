class Picture < ActiveRecord::Base
	belongs_to :user
	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	

	def width
		geo = Paperclip::Geometry.from_file(photo.to_file(:original))
		geo.width
	end
	
	def height
		geo = Paperclip::Geometry.from_file(photo.to_file(:original))
		geo.height
	end
	
	def resize     
     	geo = Paperclip::Geometry.from_file(photo.to_file(:original))
     	ratio = geo.width/geo.height  

     	min_width  = 142
	     min_height = 119

    	 if ratio > 1
       		# Horizontal Image
       		final_height = min_height
       		final_width  = final_height * ratio
       		"#{final_width.round}x#{final_height.round}!"
     	else
       		# Vertical Image
       		final_width  = min_width
       		final_height = final_width * ratio
       		"#{final_height.round}x#{final_width.round}!"
     	end
  	end
end

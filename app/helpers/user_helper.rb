module UserHelper

	def pic_line(options)		
			pic = @currentPics[options[:index]]				
			new_width = (pic.width * (@pic_height / pic.height)).floor
			if (options[:extra])
				new_width = @max_extra_width if (new_width > @max_extra_width)
			else				
				new_width = @max_width if (new_width > @max_width)
			end
			
	  		image_tag pic.photo.url(:thumb), :size => "#{new_width}x#{@pic_height}"
	end
	
end

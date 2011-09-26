class UserController < ApplicationController
	
	GridSize = 500
	
	before_filter :authorize, :except => ["signup", "try_create", "login"]

	def authorize
		return true if @user
		report_error("You need to be logged in !")
	end
	
	def try_create
		if (User.find_by_email(params[:user][:email]) != nil)
			return report_error("Email already excist!")
		else
		newUser = User.create(params[:user])
		session['user'] = newUser.id
		redirect_to :action => "show", :id => newUser.id
		end
		
	end
		
	def show
		@currentPics = @user.all_pic
		num_of_pic = @currentPics.size
		@normal_lines = 0...0
		@wider_lines = 0...0
		unless (num_of_pic == 0)
			rows = Math.sqrt(num_of_pic).floor
			@cols = num_of_pic / rows
			@pic_height = (GridSize / rows).floor
			@max_width = (GridSize / @cols).floor
			@max_extra_width = (GridSize / (@cols + 1)).floor			
			rows_with_extra_pic = num_of_pic.modulo(rows*@cols)
			@normal_lines = 0..(rows - rows_with_extra_pic - 1)
			@wider_lines = (rows - rows_with_extra_pic)..(rows - 1)
		end
		
	end
	
	def logout
		session['user'] = nil
		redirect_to :controller => "main", :action => "welcome"		
		
	end
	
	def login
		userKeys = params[:user]
		user = User.find_by_email(userKeys[:email])
		valid = false
		if (user)
			if (user.my_password?(userKeys[:password]))
				session['user'] = user
				valid = true
												
			end
			
		end
		
		unless (valid)
			return report_error("email/password were incorrect")			
		end
		
		redirect_to	:action => "show", :id => user.id
		
	end
	
	def add_picture
		if (params[:pictur] != nil && file_type = params[:pictur][:photo].content_type.match(/image/))
			newPic = Picture.create(params[:pictur])
			newPic.user_id = @user.id
			newPic.save
		else
			return report_error("Wrong file path or file type")
		end
		
		redirect_to	:action => "show"
	end
	
end

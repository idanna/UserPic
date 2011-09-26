class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :is_logged
  
  def is_logged()
  	if session['user']
  		@user = User.find(session['user'])
  	end
  	
  end
 	
  def report_error(message)
  	@message = message
  	render("main/error")
  	return false
  end 	
  
end

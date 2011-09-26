class MainController < ApplicationController
	
  def welcome
  	return redirect_to :controller => "user", :action => "show" if @user
  end  

end

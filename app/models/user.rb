class User < ActiveRecord::Base
	has_many :pictures
	
	def nice_name
		"#{self.first_name} #{self.last_name}"
	end
	
	def my_password?(password)
		password == self.password
	end
	
	def all_pic
		self.pictures.find(:all)
	end
	
end

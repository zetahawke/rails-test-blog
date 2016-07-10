class RegistrationsController < Devise::RegistrationsController

	def new
		super
	end

	def create
		super
	end

	def update
		super
	end

	private
	def sign_up_params
		allow = [:email, :username, :password, :password_confirmation]
		params.require(resource_name).permit(allow)
	end
end
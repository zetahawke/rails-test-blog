class OmniauthCallbacksController < ApplicationController
	def facebook
		auth = request.env["omniauth.auth"]
		#raise auth.inspect
		data = {
			nombre: auth.info.first_name,
			apellido: auth.info.last_name,
			username: auth.info.name.delete(' ')[0, 20],
			email:auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}

		@user = User.find_or_create_by_omniauth(data)
		#raise @user.inspect
		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
		else
			session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save

			session[:omniauth_data] = data

			redirect_to new_user_registration_url
		end

	end

	def twitter
		auth = request.env["omniauth.auth"]
		#raise auth.to_yaml
		data = {
			nombre: auth.info.first_name,
			apellido: "",
			username: auth.info.nickname,
			email: "",
			provider: auth.provider,
			uid: auth.uid
		}

		@user = User.find_or_create_by_omniauth(data)
		#raise @user.inspect
		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
		else
			session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save

			session[:omniauth_data] = data

			redirect_to new_user_registration_url
		end
	end

	def failure
		auth = request.env["omniauth.auth"]

		raise auth.inspect
	end
end
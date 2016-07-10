class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def follow
		friend_id = post_params

		respond_to do |format|
			if current_user.follow!(post_params[:friend_id])
				format.json {head :no_content}
			else
				format.json {render json: post_params}
			end
		end
	end

	private
	def post_params
		params.require(:user).permit(:friend_id)
	end
end
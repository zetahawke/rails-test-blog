class PaymentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@payment = current_user.payments.new(post_params)

		respond_to do |format|
			if @payment.save
				format.html {redirect_to cart_path}
				format.json {head :no_content}
			else
				redirect_to Post.find(post_params[:post_id]), error: "No pudimos procesar tu compra"
				format.json {head :no_content}
			end
		end
	end

	def cart
		@payments = current_user.payments.where(status:1)
	end

	def express
		price = current_user.total_to_pay
		response = EXPRESS_GATEWAY.setup_purchase(price*100,
				ip: request.remote_ip,
				return_url: "http://localhost:3000/transactions/checkout",
				cancel_return_url: "http://localhost:3000/cart",
				name: "Checkout de compras en BlogRails",
				amount: price*100
			)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token, review: false)
	end

	def purchases
		@payments = current_user.payments.where(status:2)
	end

	private
	def post_params
		params.require(:payment).permit(:post_id)
	end
end

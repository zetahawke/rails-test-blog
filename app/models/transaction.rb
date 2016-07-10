class Transaction < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true
  validates :payerid, presence: true
  validates :ip_address, presence: true

  def pay?
  	response = process_purchase
  	self.response = response.message
  	self.save
  	if response.success?
  		self.user.payments.each do |payment|
  			payment.update(status: 2)
  		end
  		true
  	else
  		false
  	end
  end

  private

  def process_purchase
  	EXPRESS_GATEWAY.purchase(self.user.total_to_pay * 100, purchase_options)
  end

  def purchase_options
  	{
  		ip: self.ip_address,
  		token: self.token,
  		payer_id: self.payerid
  	}
  end
end

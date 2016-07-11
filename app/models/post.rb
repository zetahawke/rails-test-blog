class Post < ActiveRecord::Base
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  belongs_to :user, dependent: :destroy

  has_many :attachments
  has_many :payments

  validates :tittle, presence: true, uniqueness: true

  before_save :default_values



  def default_values
  	self.price ||= 0
  end
end

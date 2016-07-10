class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :twitter]



  validates :username, presence: true, uniqueness: true,
  		length: {in: 5..20, too_short: "Tiene que tener al menos 5 caracteres",
  			too_long: "Tiene que tener maximo 20 caracteres"},
  		format: {with: /([A-Za-z0-9\-\_]+)/, message: "Tu nombre solo puede tener letras, numeros y guiones"}

  #validate :validacion_personalizada, on: :create

  has_many :posts
  has_many :friendships, foreign_key: "user_id", dependent: :destroy
  has_many :follows, through: :friendships, source: :friend
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"  
  has_many :followers, through: :followers_friendships, source: :user
  has_many :payments
  has_many :transactions

  def total_to_pay
    self.payments.where(status: 1).joins("INNER JOIN posts on posts.id == payments.post_id").sum("price")
  end


  def follow!(amigo_id)
    friendships.create!(friend_id: amigo_id)
  end

  def can_follow?(amigo_id)
    not amigo_id == self.id or friendships.where(friend_id: amigo_id).size > 0
  end

  def self.find_or_create_by_omniauth(auth)
  	user = User.where(provider: auth[:provider], uid: auth[:uid]).first

  	unless user
  		user = User.create(
  				nombre: auth[:nombre],
  				apellido: auth[:apellido],
  				username: auth[:username],
  				email: auth[:email],
  				uid: auth[:uid],
  				provider: auth[:provider],
  				password: Devise.friendly_token[0, 20]
  			)
  	end

  	user
  	#raise user.inspect
  end

  # sobre escribe el metodo de validatable de devise
  def email_required?
    false
  end


=begin
  def duplicated
    list = [1,2,3,1,4,1,3,2,4,5,6,7]

    #list.select{ |e| list.count(e) > 1 }.uniq
    obj = Hash.new

    list.each do |n|
      if obj["#{n}"]
        obj["#{n}"] = (obj["#{n}"] + 1)
      else
        obj["#{n}"] = 1
      end
    end

    obj

  end


=end

  #private

  #def validacion_personalizada
  #	if true
  #		""
  #	else
  #		errors.add(:username, "Tu username no es valido")
  #	end
  #end
end

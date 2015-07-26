# user model
class User < ActiveRecord::Base
  # in the user model it seems that I add all the constraints needed before
  # entering the database. Therefore, validation and formalization of data.

  attr_accessor :remember_token # create a token without storing it in the db.

  # standardise email case before saving to database
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? # remember token is verified againts the one of the user
    return false if remember_token.nil?
    BCrypt::Password.new(remember_digest).is_password(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end

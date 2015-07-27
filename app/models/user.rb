# user model
class User < ActiveRecord::Base
  # in the user model it seems that I add all the constraints needed before
  # entering the database. Therefore, validation and formalization of data.

  # create a token without storing it in the db.
  attr_accessor :remember_token

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

  # Updates the remember digest, after having assigned it with User.new_token
  def User.digest(string)
    cost = nil
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    # use self.some_variable to assign this to the object as an attribute
    # thanks also to the attr_accessor :remember_token on top of the model.
    self.remember_token = User.new_token
    # call the method User.digest to update the remember attribute in the db.
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # remember token is verified againts the one of the user
  def authenticated?(remember_token)
    return false if remember_token.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end

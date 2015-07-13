# user model
class User < ActiveRecord::Base
  # in the user model it seems that I add all the constraints needed before
  # entering the database. Therefore, validation and formalization of data.

  # standardise email case before saving to database
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX }, #valites email format
			  uniqueness: {case_sensitive: false}

	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password
end

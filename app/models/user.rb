class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_secure_password
  before_save { self.username = username.downcase }
  before_save { self.email = email.downcase }
  validates :username,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }


  def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
                                                BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Micropost.all
  end

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

end
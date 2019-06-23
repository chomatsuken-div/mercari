class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname,
    presence: true, length: { maximum: 20 },
    uniqueness: true

  validates :email,
    presence: true,
    uniqueness: true

  validates :password, presence: true, if: :sns?
  validates :password, length: {minimum: 6, maximum: 128}


  has_many :sns_credentials, dependent: :destroy
  has_one :card
  has_many :products

  def sns?
    @sns == nil
  end

end

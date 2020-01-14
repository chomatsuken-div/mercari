class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname,
    presence: true, length: { maximum: 20 },
    uniqueness: true

  validates :email,
    presence: true,
    uniqueness: true

  validates :password, presence: true, if: :sns?
  validates :password, length: {minimum: 6, maximum: 128}

  validates :first_name,:last_name, :first_name_kana, :last_name_kana,:birthday, presence: true
  validates :phone_number ,presence: true



  has_many :sns_credentials, dependent: :destroy
  has_one :card
  has_one :address
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
  has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'

  def sns?
    @sns == nil
  end

end

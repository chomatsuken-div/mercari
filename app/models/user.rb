class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nickname, presence: true, length: { maximum: 6 }
  validates :nickname, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

end

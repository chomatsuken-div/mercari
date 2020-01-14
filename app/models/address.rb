class Address < ApplicationRecord
    belongs_to :user

    validates :first_name,:last_name, :first_name_kana, :last_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, presence: true

end

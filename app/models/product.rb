class Product < ApplicationRecord
    has_many :images
    accepts_nested_attributes_for :images, allow_destroy: true

    belongs_to :category
    belongs_to :brand
    belongs_to :user

    enum status: { sell: 0, buyed: 1 , sell_stop: 2}

    include JpPrefecture
    jp_prefecture :prefecture_code

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :state
    belongs_to_active_hash :shopping_fee
    belongs_to_active_hash :expected_date


end

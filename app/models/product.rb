class Product < ApplicationRecord
    has_many :images
    accepts_nested_attributes_for :images, allow_destroy: true

    belongs_to :category
    belongs_to :brand
    belongs_to :seller, class_name: 'User'
    belongs_to :buyer, class_name: 'User', optional: true

    enum status: { sell: 0, buyed: 1 , sell_stop: 2}

    include JpPrefecture
    jp_prefecture :prefecture_code

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :state
    belongs_to_active_hash :shopping_fee
    belongs_to_active_hash :expected_date

    def product_soldout?(product)
        product.status == 2
    end

    def previous
      Products.all.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
    end

    def next
      group.posts.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
    end
end

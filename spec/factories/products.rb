FactoryBot.define do
  factory :product do
    name {"レモン"}
    price {3000}
    state_id {1}
    shopping_fee_id {1}
    prefecture_code {1}
    brand_id {1}
    expected_date_id {1}
    category_id {14}
    category_root_id {1}
    user
    after(:build) do |product|
      product.images << build(:image)
    end
  end
end

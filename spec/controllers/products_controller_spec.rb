require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  describe '#create' do
    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        image =  File.open("#{Rails.root}/public/images/test_image.jpg")
        subject {
          post :create, 
          params: { product: {
            name: "test",
            price: 1000,
            state_id: 1,
            shopping_fee_id: 1,
            prefecture_code: 1,
            brand_id: 1,
            expected_date_id: 1,
            category_id: 14,
            seller_id: user.id,
            category_root_id: 1,
            images_attributes: [src: image]
          }}
        }
        it '商品出品成功' do
          expect{ subject }.to change(Product, :count).by(1)
        end
      end
    end
  end
end

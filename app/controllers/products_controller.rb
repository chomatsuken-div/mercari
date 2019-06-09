class ProductsController < ApplicationController

  def index
    @products = Product.all.reverse_order.limit(4)
    @category_products = Category.find(238).products.limit(4)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.images.new
    @parents = Category.all.order("id ASC").limit(13)
      if params[:parent]
        @child_categories = Category.where('ancestry = ?', "#{params[:parent]}")
      else
        @grandchild_categories = Category.where('ancestry LIKE ?', "%/#{params[:child]}")
      end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        redirect_to root_path
      else
        @parents = Category.order("id ASC").limit(13)
        render :new
      end
  end

  private

  def product_params
    params.require(:product).permit(:name, :detail, :size, :category_id, :brand_id, :state_id, :shopping_fee_id, :prefecture_code,:expected_date_id, :price,  images_attributes: [:src]).merge(user_id: current_user.id)
  end
end

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :category_child]
  before_action :set_search

  def index
    @products = Product.all.reverse_order.limit(4)
    @category_products = Category.find(238).products.limit(4)
    @parents = Category.all.order("id ASC").limit(13)
  end

  def show
    @parents = Category.all.order("id ASC").limit(13)
    @product = Product.find(params[:id])
    @product_previous = Product.where('id < ? ', @product.id).first
    @product_next = Product.where('id > ? ', @product.id).first
    @product_state = State.find(@product.state_id)
    @product_shopping_fee =ShoppingFee.find(@product.shopping_fee_id)
    @product_prefecture = JpPrefecture::Prefecture.find(@product.prefecture_code)
    @product_expected_date = ExpectedDate.find(@product.expected_date_id)
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

  def edit
    @product = Product.find(params[:id])
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

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path
    else
      redirect_to product_path
    end
  end

  def search
    @keyword = params[:q][:name_cont]
    @products = @search.result.page(params[:page]).per(48)
    @parents = Category.all.order("id ASC").limit(13)
  end

  def category_child
    @category_parent = Category.find(params[:category_id])
    @category_children = @category_parent.children
    respond_to do |format|
      format.json
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :detail, :size, :category_root_id, :category_id, :brand_id, :state_id, :shopping_fee_id, :prefecture_code,:expected_date_id, :price,  images_attributes: [:src]).merge(seller_id: current_user.id)
  end

  def set_search
    @search = Product.ransack(params[:q])
  end

  def search_params
    params.require(:q).permit!
  end
end

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_item_status, only: [:edit, :update]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品が削除されました。'
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :price, :product_description, :product_condition_id, :category_id,
                                 :shipping_cost_id, :shipping_day_id, :prefecture_id, :user_id, :price, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_item_status
    if @item.order.present?
      redirect_to root_path, alert: 'この商品は既に売却されています。'
    elsif current_user.id != @item.user_id
      redirect_to root_path, alert: 'あなたにはこのページへのアクセス権がありません。'
    end
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @item.user
  end
end

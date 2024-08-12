class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :check_order_status, only: [:index, :create]
  before_action :check_seller

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end
end

private

def order_params
  params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :street_number, :building_name, :phone_number).merge(
    user_id: current_user.id, item_id: params[:item_id], token: params[:token]
  )
end

def pay_item
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  Payjp::Charge.create(
    amount: @item.price,           # 商品の値段
    card: order_params[:token],    # カードトークン
    currency: 'jpy'                # 通貨の種類（日本円）
  )
end

def set_item
  @item = Item.find(params[:item_id])
end

def check_order_status
  return unless @item.order.present?

  redirect_to root_path, alert: 'この商品は既に購入されています。'
end

def check_seller
  if current_user.id == @item.user_id
    redirect_to root_path, alert: "自身の商品を購入することはできません。"
  end
end

class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_number, :building_name, :phone_number, :token

  # バリデーションの定義
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_number
    validates :phone_number, length: { minimum: 10, maximum: 11 },
                             format: { with: /\A\d{10,11}\z/, message: 'must be numeric, half-width and either 10 or 11 digits long' }
    validates :token
  end

  def save
    # 購入情報を保存
    order = Order.create(user_id:, item_id:)

    # 配送先情報を保存
    ShippingOrigin.create(postal_code:, prefecture_id:, city:, street_number:,
                          building_name:, phone_number:, order_id: order.id)
  end
end

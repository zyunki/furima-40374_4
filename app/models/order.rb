class Order < ApplicationRecord
  belongs_to :user 
  belongs_to :item
  has_one :shipping_origin

end

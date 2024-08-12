class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i
  validates :password, presence: true,
                       length: { minimum: 6 },
                       format: { with: VALID_PASSWORD_REGEX, message: 'は半角6文字以上と英小文字・数字それぞれ1文字以上含む必要があります' },
                       confirmation: true

  validates :first_name, :last_name, presence: true,
                                     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }

  validates :first_name_kana, :last_name_kana, presence: true,
                                               format: { with: /\A[\p{katakana}ー－]+\z/, message: 'は全角カタカナで入力して下さい' }

  validates :birthday, presence: true

  has_many   :items
  has_many   :orders
end

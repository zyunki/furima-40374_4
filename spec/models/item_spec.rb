require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が出品できる場合' do
      it '全ての項目が入力されていると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it '商品名が空では出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格に半角数字以外が含まれている場合は出品できない（※半角数字以外が一文字でも含まれていれば良い）' do
        @item.price = '3000a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は300以上9999999以下の半角数字で入力してください')
      end

      it '価格が300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は300以上9999999以下の半角数字で入力してください')
      end

      it '価格が10000000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は300以上9999999以下の半角数字で入力してください')
      end

      it '商品説明が空では出品できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end

      it '商品の状態が空では出品できない' do
        @item.product_condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition can't be blank")
      end

      it 'カテゴリーが空では出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '配送料の負担が空では出品できない' do
        @item.shipping_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end

      it '配送までの日数が空では出品できない' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '配送元の地域が空では出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '商品状態が1では出品できない' do
        @item.product_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition can't be blank")
      end

      it 'カテゴリーが1では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '配送料の負担が1では出品できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end

      it '配送までの日数が1では出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '配送元の地域が1では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'ユーザーが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end

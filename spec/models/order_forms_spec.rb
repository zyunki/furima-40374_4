require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user:)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end

      it 'building_nameは空でも保存できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'user_idが空では保存できないこと' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では保存できないこと' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが空だと保存できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが「3桁ハイフン4桁」の半角文字列のみ保存可能' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと保存できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'street_numberが空だと保存できない' do
        @order_form.street_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street number can't be blank")
      end

      it 'phone_numberが空だと保存できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下の場合保存できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be numeric, half-width and either 10 or 11 digits long')
      end

      it 'phone_numberが12桁以上の場合保存できない' do
        @order_form.phone_number = '1234567890123'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be numeric, half-width and either 10 or 11 digits long')
      end

      it 'phone_numberに半角数字以外が含まれている場合保存できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number must be numeric, half-width and either 10 or 11 digits long')
      end

      it 'tokenが空では登録できないこと' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

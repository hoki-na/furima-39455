require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '購入機能' do
    context 'すべての条件を満たしていれば購入できる' do
      it '入力条件を満たせば登録できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名は任意であること' do
        @purchase_address.house_name = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が必須であること' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でない場合は保存できないこと' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it '都道府県「---」が選択されている場合は出品できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が必須であること' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が必須であること' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end

      it '電話番号が必須であること' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できないこと' do
        @purchase_address.phone_number = '123456789' 
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number must be 10 to 11 digits and contain only numbers")
      end

      it '電話番号が12桁以上では購入できないこと' do
        @purchase_address.phone_number = '123456789012' 
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number must be 10 to 11 digits and contain only numbers")
      end

      it '電話番号に半角数字以外が含まれている場合は購入できないこと' do
        @purchase_address.phone_number = '123456789a'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number must be 10 to 11 digits and contain only numbers")
      end

      it "tokenが空では登録できないこと" do
        purchase_address = PurchaseAddress.new(token: nil)
        purchase_address.valid?
        expect(purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていなければ購入できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      
      it 'itemが紐付いていなければ購入できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
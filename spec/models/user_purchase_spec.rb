require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '商品購入機能' do
    before do
      @purchase = FactoryBot.build(:user_purchase)
    end

    it '必須項目が全てあれば登録できる' do
      expect(@purchase).to be_valid
    end

    it 'クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと' do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が必須であること' do
      @purchase.postal_code = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '郵便番号はハイフンが必須であること' do
      @purchase.postal_code = Faker::Number.leading_zero_number(digits: 7)
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '郵便番号は桁数が多いと登録できないこと' do
      @purchase.postal_code = "#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '郵便番号は桁数が少ないと登録できないこと' do
      @purchase.postal_code = "#{Faker::Number.number(digits: 2)}-#{Faker::Number.number(digits: 3)}"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県が必須であること(未選択の場合)' do
      @purchase.prefecture_id = 1
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '都道府県が必須であること(空の場合)' do
      @purchase.prefecture_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
    end

    it '市区町村が必須であること' do
      @purchase.city = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("City can't be blank")
    end

    it '番地が必須であること' do
      @purchase.house_number = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("House number can't be blank")
    end

    it '電話番号が必須であること' do
      @purchase.phone_number = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. NO hyphen(-)')
    end

    it '電話番号はハイフンが不要であること' do
      @purchase.phone_number = "#{Faker::Number.leading_zero_number(digits: 3)}-#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. NO hyphen(-)')
    end

    it '電話番号は桁数が少ないと登録できないこと' do
      @purchase.phone_number = Faker::Number.leading_zero_number(digits: 8)
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. NO hyphen(-)')
    end

    it '電話番号は桁数が多いと登録できないこと' do
      @purchase.phone_number = Faker::Number.leading_zero_number(digits: 13)
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('Phone number is invalid. NO hyphen(-)')
    end
  end
end

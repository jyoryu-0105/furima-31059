require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it '必須項目が全てあれば登録できる' do
      expect(@item).to be_valid
    end

    it '商品画像を1枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.details = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Details can't be blank")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it 'カテゴリーの情報が必須であること(空の場合)' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
    end

    it '商品の状態についての情報が必須であること' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 1')
    end

    it '商品の状態についての情報が必須であること(空の場合)' do
      @item.status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank", 'Status is not a number')
    end

    it '配送料の負担についての情報が必須であること' do
      @item.shipping_cost_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
    end

    it '配送料の負担についての情報が必須であること(空の場合)' do
      @item.shipping_cost_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping cost can't be blank", 'Shipping cost is not a number')
    end

    it '発送元の地域についての情報が必須であること' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '発送元の地域についての情報が必須であること(空の場合)' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
    end

    it '発送までの日数についての情報が必須であること' do
      @item.shipping_date_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping date must be other than 1')
    end

    it '発送までの日数についての情報が必須であること(空の場合)' do
      @item.shipping_date_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping date can't be blank", 'Shipping date is not a number')
    end

    it '価格についての情報が必須であること' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格の範囲が、¥300未満では保存できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格の範囲が、¥999,999,999より高いと保存できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than 10000000')
    end

    it '販売価格は半角数字のみ保存可能であること' do
      @item.price = Faker::Name.initials(number: 2)
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end

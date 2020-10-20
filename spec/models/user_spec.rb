require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '必須項目が全てあれば登録できる' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが重複していたら登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに＠がなければ登録できない' do
      @user.email = '1234567890'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以下では登録できない' do
      @user.password = 'A12B3'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合でないと登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字を混合して使用してください')
    end

    it 'password_confirmationが空だと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordと確認用が一致しないと登録できない' do
      @user.password = 'A12B34'
      @user.password_confirmation = 'A12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名は、名字が空では登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー本名は、名前が空では登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = Faker::Name.initials(number: 2)
      @user.last_name = Faker::Name.initials(number: 2)
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角文字を使用してください', 'Last name は全角文字を使用してください')
    end

    it 'ユーザー本名のフリガナは、名字が空では登録できない' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、名前が空では登録できない' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、全角（カタカナ）でないと登録できない' do
      @user.first_name_kana = Gimei.name.first.kanji
      @user.last_name_kana = Gimei.name.last.kanji
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナを使用してください', 'Last name kana は全角カタカナを使用してください')
    end

    it '生年月日が空では登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end

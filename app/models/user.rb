class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :nickname,        presence: true
    validates :birthday,        presence: true
  with_options presence: true,  format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角文字を使用してください' } do
    validates :first_name,      presence: true
    validates :last_name,       presence: true
  end
  with_options presence: true,  format: { with: /\A[ァ-ン]+\z/, message: 'は全角カタカナを使用してください' } do
    validates :first_name_kana, presence: true
    validates :last_name_kana,  presence: true
  end
    validates :password,        format: { with:/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message:'は半角英数字を混合して使用してください'}
end
# テーブル設計

## users テーブル

| Column          | Type        | Options      |
|:----------------|------------:|:------------:|
| nickname        | string      | null:false   |
| email           | string      | null:false   |
| password        | string      | null:false   |
| first_name      | string      | null:false   |
| last_name       | string      | null:false   |
| first_name_kana | string      | null:false   |
| last_name_kana  | string      | null:false   |
| birthday_year   | integer     | null:false   |
| birthday_month  | integer     | null:false   |
| birthday_day    | integer     | null:false   |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options                        |
|:-----------------|-----------:|:------------------------------:|
| name             | string     | null:false                     |
| category         | string     | null:false                     |
| price            | integer    | null:false                     |
| item_status      | string     | null:false                     |
| shipping_cost    | string     | null:false                     |
| shipping_address | string     | null:false                     |
| shipping_date    | string     | null:false                     |
| item_details     | text       | null:false                     |
| user             | references | null: false, foreign_key: true |

### Association

- has_one    :purchase
- belongs_to :user

## purchases テーブル

| Column                | Type       | Options                        |
|:----------------------|-----------:|:------------------------------:|
| card_number           | integer    | null:false                     |
| expiration_date_month | integer    | null:false                     |
| expiration_date_year  | integer    | null:false                     |
| security_code         | integer    | null:false                     |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

## addresses テーブル

| Column       | Type       | Options                        |
|:-------------|-----------:|:------------------------------:|
| postal_code  | integer    | null:false                     |
| prefecture   | string     | null:false                     |
| city         | string     | null:false                     |
| house_number | string     | null:false                     |
| building     | string     | null:false                     |
| phone_number | integer    | null:false                     |
| purchase     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase


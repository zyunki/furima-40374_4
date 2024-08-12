# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| name               | string              | null: false               |
| first_name         | string              | null: false               |
| last_name          | string              | null: false               |
| first_name_kana    | string              | null: false               |
| last_name_kana     | string              | null: false               |
| birthday           | date                | null: false               |

### Association

* has_many   :items
* has_many   :orders


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| product_name                        | string     | null: false                    |
| price                               | integer    | null: false                    |
| product_description                 | text       | null: false                    |
| product_condition_id                | integer    | null: false                    |
| category_id                         | integer    | null: false                    |
| shipping_cost_id                    | integer    | null: false                    |
| shipping_days_id                    | integer    | null: false                    |
| prefecture_id                       | integer    | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to  :user
* has_one     :order

## orders table

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to  :user
- belongs_to  :item
* has_one     :shipping_origin

## shipping_origins table

| Column              | Type            | Options                        |
|---------------------|-----------------|--------------------------------|
| postal_code         | string          | null: false                    |
| prefecture_id       | integer         | null: false                    |
| city                | string          | null: false                    |
| street_number       | string          | null: false                    |
| building_name       | string          |                                |
| phone_number        | string          | null: false                    |
| order               | references      | null: false, foreign_key: true |


### Association

- belongs_to :order

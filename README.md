## usersテーブル

|Column     |Type   |Options|
|-----------|-------|-------|
|nickname   |string |null: false, unique: true, add_index|
|email      |string |null: false, unique: true|
|password   |string |null: false|
|first_name |string |null: false|
|family_name|string |null: false|
|birth      |integer|null: false|
|tell       |integer|null: false|
|address    |string |null: false|
|card       |string |       |

### Association
- has_many :sns_credentials
- has_one :point
- has_many :banks
- has_many :reviews
- has_one :item(seller)
- has_one :item(buyer)
- has_many :likes
- has_many :item,through::members
- has_many :messages

## sns_credentialsテーブル
|Column  |Type     |Options|
|--------|---------|-------|
|uid     |string   |null: false, unique: true|
|provider|string   |null: false|
|user_id |refarence|foreign_key: true|

### Association
- belongs_to :user

## pointsテーブル
|Column  |Type     |Options|
|--------|---------|-------|
|point   |integer  |       |
|user_id |refarence|foreign_key: true|

### Association
- belongs_to :user

## banksテーブル
|Column       |Type     |Options|
|-------------|---------|-------|
|name         |string   |null: false|
|bank_number  |string   |null: false, unique: true|
|user_name    |string   |null: false|
|user_id      |refarence|foreign_key: true|

### Association
- belongs_to :user

## reviewsテーブル
|Column |Type     |Options|
|-------|---------|-------|
|item_id|reference|foreign_key: true|
|user_id|reference|foreign_key: true|
|rate   |integer  |       |

### Association
- belongs_to :item
- belongs_to :user

---------------------------------------------------------------------------

## itemsテーブル

|Column     |Type     |Options|
|-----------|---------|-------|
|name       |string   |null: false, unique: true, add_index|
|price      |integer  |null: false|
|stage      |integer  |null: false|
|image      |string   |       |
|seller_id  |refarence|foreign_key:{ to_table:users},index:false|
|buyer_id   |refarence|foreign_key:{ to_table:users},index:false|
|brand_id   |refarence|foreign_key: true|
|category_id|refarence|foreign_key: true|
|like_count |integer  |       |


### Association
- has_many :reviews
- belongs_to :user(seller)
- belongs_to :user(buyer)
- belongs_to :brand
- belongs_to :category
- has_one :size
- has_many :likes
- has_many :user,through::members
- has_many :messages

## brandsテーブル
|Column|Type  |Options|
|------|------|-------|
|name  |string|null: false, unique: true, add_index|

### Association
- has_one :item
- has_one :category

## categorysテーブル

|Column        |Type     |Options|
|--------------|---------|-------|
|brand_id      |refarence|foreign_key: true|
|name          |string   |null: false|
|parent_id     |integer  |null: false|
|lft           |integer  |       |
|rgt           |integer  |       |
|depth         |integer  |       |
|children_count|integer  |       |

### Association
- has_one :item
- belongs_to :brand

## sizesテーブル
|Column |Type     |Options|
|-------|---------|-------|
|item_id|reference|foreign_key: true|
|size   |string   |null: false|

### Association
- belongs_to :item

## likesテーブル
|Column |Type     |Options|
|-------|---------|-------|
|item_id|refarence|foreign_key: true|
|user_id|refarence|foreign_key: true|
|like   |integer  |foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

------------------------------------------------------------

## membersテーブル
|Column |Type     |Options|
|-------|---------|-------|
|item_id|refarence|foreign_key: true|
|user_id|refarence|foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

## messagesテーブル

|Column |Type     |Options|
|-------|---------|-------|
|text   |text     |       |
|image  |string   |       |
|user_id|refarence|foreign_key: true|
|item_id|refarence|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

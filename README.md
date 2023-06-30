## usersテーブル

|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|nickname           |string |null: false              |
|email              |string |null: false,unique: true |
|encrypted_password |string |null: false              |
|first_name         |string |null: false              |
|last_name          |string |null: false              |
|first_name_kana    |string |null: false              |
|last_name_kana     |string |null: false              |
|birthday           |date   |null: false              |

### Association
has_many :items
has_many :purchases


## itemsテーブル

|Column             |Type       |Options                        |
|-------------------|-----------|-------------------------------|
|item_name          |string     |null: false                    |
|description        |text       |null: false                    |
|category_id        |integer    |null: false                    |
|condition_id       |integer    |null: false                    |
|delivery_charge_id |integer    |null: false                    |
|prefecture_id      |integer    |null: false                    |
|ship_date_id       |integer    |null: false                    |
|price              |integer    |null: false                    |
|user               |references |null: false,foreign_key: true  |

### Association
has_one :purchase
belongs_to :user


## purchasesテーブル

|Column |Type       |Options                        |
|-------|-----------|-------------------------------|
|item   |references |null: false, foreign_key: true |
|user   |references |null: false, foreign_key: true |

### Association
has_one :address
belongs_to :item
belongs_to :user


## addressテーブル

|Column           |Type       |Options                        |
|-----------------|-----------|-------------------------------|
|post_code        |string     |null: false                    |
|prefecture_id    |integer    |null: false                    |
|municipality     |string     |null: false                    |
|house_number     |string     |null: false                    |
|house_name       |string     |                               |
|phone_number     |string     |null: false                    |
|purchase         |references |null: false, foreign_key: true |

### Association
belongs_to :purchase
## Tabel名

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email |string|null: false unique: true|
|password|string|null: false unique: true|
|firstname|string|null: false|
|lastname|string|null: false|
|birthday|int|null: false|



### Association
nickname----has_one
email----has_one
password----has_one
firstname----has_many
lastname----has_many
birthday----has_many
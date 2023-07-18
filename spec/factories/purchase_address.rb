FactoryBot.define do
  factory :purchase_address do
    post_code { '123-4567' }
    prefecture_id { 1 }
    municipality { '横浜市緑区' }
    house_number { '青山1-1-1' }
    house_name { '柳ビル303' }
    phone_number { '01234567890' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
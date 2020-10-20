# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    product_id { 1 }
    child_id { 1 }
    shipping_name { "Sansa Stark" }
    address { "123 Winterfell Path" }
    zipcode { "90210" }
    user_facing_id { "8908909" }
    paid { true }
    
    trait :not_paid do
      paid { false }
    end
  end
end

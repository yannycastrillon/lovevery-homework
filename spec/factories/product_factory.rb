# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name {Faker::Commerce.product_name }
    description { Faker::Commerce.product_name }
    price_cents { Faker::Commerce.price * 100 }
    age_low_weeks { 0 }
    age_high_weeks { 52 }

    trait :between_0_and_12 do
      age_low_weeks { 0 }
      age_high_weeks { 12 }
    end

    trait :between_13_and_17 do
      age_low_weeks { 13 }
      age_high_weeks { 17 }
    end

    trait :between_21_and_26 do
      age_low_weeks { 21 }
      age_high_weeks { 26 }
    end
  end
end
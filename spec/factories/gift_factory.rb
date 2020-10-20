# frozen_string_literal: true

FactoryBot.define do
  factory :gift do
    product_id { 1 }
    child_id { 1 }
    gifter_id { 1 }

    trait :message do
      message { Faker::TvShows::GameOfThrones.quote }
    end
  end
end
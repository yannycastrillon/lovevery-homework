# frozen_string_literal: true

FactoryBot.define do
  factory :gifter do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    sequence(:email) { |n| "#{first_name}.#{last_name}_#{n}@example.com".downcase }
  end
end
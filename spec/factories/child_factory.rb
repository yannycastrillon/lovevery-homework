# frozen_string_literal: true

FactoryBot.define do
  factory :child, aliases: [:son, :daughter] do
    full_name { "#{Faker::Name.unique.first_name} #{parent_last_name}" }
    birthdate { Faker::Date.birthday(min_age: 0, max_age: 5) }
    parent_name { "#{Faker::Name.unique.first_name} #{parent_last_name}" }

    transient do
      parent_last_name { Faker::Name.unique.last_name }
    end
  end
end
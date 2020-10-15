# frozen_string_literal: true

module BasicNameUtils
  def first_name
    Faker::Name.unique.first_name
  end

  def last_name
    Faker::Name.unique.last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
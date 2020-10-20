# frozen_string_literal: true

class SearchGifterService < ApplicationService
  def initialize(first_name, last_name, email)
    @first_name = first_name
    @last_name =  last_name
    @email = email
  end

  def call
    Gifter.find_or_create_by!(first_name: first_name, last_name: last_name, email: email)
  end

  private

  attr_reader :first_name, :last_name, :email
end
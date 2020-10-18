# frozen_string_literal: true

class SearchChildService < ApplicationService
  def initialize(full_name, birthdate, parent_name)
    @birthdate = birthdate
    @full_name = full_name.downcase.titleize
    @parent_name = parent_name.downcase.titleize
  end

  def call
    child = Child.find_by(full_name: full_name, birthdate: birthdate, parent_name: parent_name)
    unless child
      return Failure.new(error: Errors::ChildNotFound.new('Child was not found'))
    end

    Success.new(object: child)
  end

  private

  attr_reader :full_name, :birthdate, :parent_name
end
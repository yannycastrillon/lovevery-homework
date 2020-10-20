# frozen_string_literal: true

class Success
  attr_reader :object, :status

  def initialize(object:)
    @object = object
    @status = :success
  end
end
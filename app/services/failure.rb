# frozen_string_literal: true

class Failure
  attr_reader :error, :status

  def initialize(error:)
    @error = error
    @status = :failure
  end
end
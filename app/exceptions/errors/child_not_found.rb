# frozen_string_literal: true

module Errors
  class ChildNotFound < StandardError
    def initialize(msg, exceptionType='custom')
      @exceptionType = exceptionType
      super(msg)
    end
  end
end
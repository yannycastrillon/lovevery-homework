#frozen_string_literal: true

class ChildDecorator < Draper::Decorator
  def titelize_name
    object.full_name.downcase.titelize
  end
end
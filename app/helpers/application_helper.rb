module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def number_two_decimals(number)
    number_with_precision(number, precision: 2)
  end
end

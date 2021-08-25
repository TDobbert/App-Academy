require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :birth_date, presence: true

  def age
    years = Date.today.year - birth_date.year
    months = Date.today.month - birth_date.month
    days = Date.today.day - birth_date.day

    from_time = Time.now - years.year - months.month - days.day

    time_ago_in_words(from_time)
  end
end

require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = [black, white, orange, yellow, grey, blue].freeze

  validates :birth_date, :name, presence: true
  validates :color, presence: true, inclusion: { in: COLORS }
  validates :sex, presence: true, inclusion: { in: [M, F] }

  def age
    years = Date.today.year - birth_date.year
    months = Date.today.month - birth_date.month
    days = Date.today.day - birth_date.day

    from_time = Time.now - years.year - months.month - days.day

    time_ago_in_words(from_time)
  end
end

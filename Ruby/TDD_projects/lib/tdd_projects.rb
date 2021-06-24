class Array
  def my_uniq
    hash = {}
    self.each { |i| hash[i] = nil }
    hash.keys
  end

  def two_sum
    arr = []
    (0...self.length).each do |i|
      (0...self.length).each do |j|
        arr << [i, j] if (self[i] + self[j]).zero? && i < j
      end
    end
    arr
  end

  def my_transpose
    dimensions = self.first.length
    transposed_matrix = Array.new(dimensions) { Array.new(dimensions) }

    dimensions.times do |i|
      dimensions.times do |j|
        transposed_matrix[j][i] = self[i][j]
      end
    end
    transposed_matrix
  end

  def stock_picker
    most_profit = 0
    most_profitable_days = nil

    self.each_index do |buy_date|
      self.each_index do |sell_date|
        next if sell_date < buy_date

        profit = self[sell_date] - self[buy_date]
        if profit > most_profit
          most_profitable_days = [buy_date, sell_date]
          most_profit = profit
        end
      end
    end
    most_profitable_days
  end
end

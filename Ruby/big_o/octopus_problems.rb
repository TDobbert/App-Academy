def sluggish_octopus(fish)
  biggest_fish = ''
  fish.each do |fish1|
    fish.each do |fish2|
      biggest_fish = fish1 if fish1.length > fish2.length
    end
  end
  biggest_fish
end

def quick_sort(fish)
  return fish if fish.length <= 1

  pivot_arr = [fish.first]
  left_side = fish[1..-1].select { |el| el.length < fish.first.length }
  right_side = fish[1..-1].select { |el| el.length >= fish.first.length }
  quick_sort(left_side) + pivot_arr + quick_sort(right_side)
end

def dominant_octopus(fish)
  quick_sort(fish).last
end

def clever_octopus(fish)
  biggest_fish = ''
  (0...fish.length).each do |i|
    biggest_fish = fish[i] if fish[i].length > fish[i - 1].length
  end
  biggest_fish
end

def slow_dance(val, tiles_arr)
  tiles_arr.each_index { |i| return i if tiles_arr[i] == val }
end

def fast_dance(val, tiles_hash)
  tiles_hash[val]
end

tiles_hash = {"up" => 0, "right-up" => 1, "right" => 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7}
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

p sluggish_octopus(fish)
p dominant_octopus(fish)
p clever_octopus(fish)
p slow_dance('up', tiles_array) # 0
p slow_dance('right-down', tiles_array) # 3
p fast_dance('up', tiles_hash) # 0
p fast_dance('right-down', tiles_hash) # 3

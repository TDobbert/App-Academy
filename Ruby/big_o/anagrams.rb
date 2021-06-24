def first_anagram?(str1, str2)
  split_str = str1.split('')
  permutations = split_str.permutation.to_a

  permutations.any? { |perm| perm == str2.split('') }
end

def second_anagram?(str1, str2)
  split_str = str2.split('')
  str1.each_char do |char|
    index = split_str.find_index(char)
    return false if index.nil?

    split_str.delete_at(index)
  end
  return true if split_str.empty?

  false
end

def third_anagram?(str1, str2)
  return true if str1.split('').sort == str2.split('').sort

  false
end

def fourth_anagram?(str1, str2)
  count = Hash.new(0)
  str1.each_char { |char| count[char] += 1 }
  str2.each_char { |char| count[char] += 1 }
  return false if count.value?(1)

  true
end

p first_anagram?('gizmo', 'sally')
p first_anagram?('elvis', 'lives')
p second_anagram?('gizmo', 'sally')
p second_anagram?('stressed', 'desserts')
p third_anagram?('gizmo', 'sally')
p third_anagram?('elvis', 'lives')
p fourth_anagram?('gizmo', 'gizme')
p fourth_anagram?('elvises', 'liveses')

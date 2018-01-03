require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = HashMap.new

  string.each_char do |ch|
    if hash_map.include?(ch)
      value = hash_map.get(ch)
      hash_map.set(ch, value + 1)
    else
      hash_map.set(ch, 1)
    end
  end

  odd_value_count = 0

  hash_map.each do |key, value|
    if value.odd?
      odd_value_count += 1
    end
  end
  odd_value_count <= 1
end
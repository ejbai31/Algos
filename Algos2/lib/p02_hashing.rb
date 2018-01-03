class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index do |el, idx|
      hashed += (el.hash + idx).hash
    end
    hashed
  end
end

class String
  def hash
    self.split("").map do |ch|
      ch.ord
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.to_a.each do |pair|
      hashed += pair[0].to_s.hash
      hashed += pair[1].hash
    end
    hashed
  end
end
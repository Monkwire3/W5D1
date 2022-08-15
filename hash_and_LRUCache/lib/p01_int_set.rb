class MaxIntSet
  
  attr_reader :store

  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise 'Out of bounds' if !is_valid?(num)

    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    return num >= 0 && num < @store.length
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    return false if @store[num % @store.length].include?(num)
    @store[num % @store.length] << num 
    return true
  end

  def remove(num)
    @store[num % @store.length].delete_at(@store[num % @store.length].index(num))
  end

  def include?(num)
    return false if @store[num % @store.length].length == 0
    @store[num % @store.length].each {|el| return true if el == num}
    return false
  end

  private

  def [](num) 
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    return false if include?(num)

    @count += 1
    resize! if @count >= @store.length
    @store[num % @store.length] << num
  end

  def remove(num)
    return if !include?(num)

    @store[num % @num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    return @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2

    resized = Array.new(@num_buckets) {[]}
    
    @store.each do |bucket|
      bucket.each {|el| resized[el % @num_buckets] << el}
    end

    @store = resized

  end
end


test_set = ResizingIntSet.new(2)
p test_set

p test_set.include?(3)

test_set.insert(3)
test_set.insert(2)
test_set.insert(6)

p test_set 
p test_set.include?(3)
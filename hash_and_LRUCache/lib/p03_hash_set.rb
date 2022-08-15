class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)

    key = key.to_s if key.is_a?(Symbol)

    return false if self.include?(key.hash)

    @count += 1

    resize! if @count >= num_buckets

    @store[key.hash % @num_buckets] << key.hash


    return true
  end

  def include?(key)
    return self[key].include?(key.hash)
  end

  def remove(key)
    return false if !include?(key)

    @store[key.hash % @num_buckets].delete(key.hash)
    @count -= 1


  end

  private


  def [](num)
    @store[num.hash % num_buckets]

    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    resized = Array.new(@num_buckets) {[]}

    @store.each do |bucket|
      bucket.each {|hsh| resized[hsh % @num_buckets] = hsh}
    end

    @store = resized

  end
end

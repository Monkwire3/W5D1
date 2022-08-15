class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    arr = self.dup

    pre_hash = 2
    op_id = 0

    while arr.length > 0
      arr[-1] = arr.pop.hash if arr[-1].is_a?(Array)

      case op_id
      when 0
        pre_hash += arr.pop
      when 1
        pre_hash -= arr.pop
      when 2
        pre_hash *= arr.pop
      when 3
        pre_hash -= arr.pop
      when 4
        pre_hash %= arr.pop
      end

      op_id = op_id == 4 ? 0 : op_id + 1
    end

    return pre_hash
  end
end

class String
  def hash
    return self.split('').map {|el| el.ord}.hash
  end
end





class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.map {|k, v| [k.to_s.ord, v] }

    sorted = arr.sort

    pre_hash = []

    sorted.each do |kv_pair|
      kv_pair.each {|el| pre_hash << el.hash}
    end


    return pre_hash.hash

  end
end



class HashMap

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
    @size = 0
  end


  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end

  def set(key, value)
    bucket_index = index(key)
    bucket = @buckets[bucket_index]

    if bucket && bucket[0] == key
      bucket[1] = value
      return
    end

    @buckets[bucket_index] = [key, value]
    @size += 1
    check_load()
  end

  def check_load()
    if @size.to_f / @capacity >= @load_factor
      expand_capacity()
    end
  end

  def index(key)
    hash_code = hash(key)
    index = hash_code % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    index
  end

  def get(key)
    bucket = @buckets[index(key)]
    return nil if bucket.nil?

    return bucket[1] if bucket[0] == key
    nil
  end

  def has?(key)
    get(key) != nil
  end

  def remove(key)
    return nil unless has?(key)

    bucket_index = index(key)
    value = @buckets[bucket_index][1]

    @buckets[bucket_index] = nil
    @size -= 1
    value

  end

  def length()
    return @size
  end

  def clear()
    @buckets = Array.new(@capacity)
    @size = 0
  end

  def keys()
    keys = []
    @buckets.each do |bucket|
      unless bucket.nil?
        keys << bucket[0]
      end
    end
    keys
  end

  def values()
    values = []
    @buckets.each do |bucket|
      unless bucket.nil?
        values << bucket[1]
      end
    end
    values
  end

  def entries()
    entries = []
    @buckets.each do |bucket|
      unless bucket.nil?
        entries << bucket
      end
    end
    entries
  end

  def expand_capacity
    old_buckets = @buckets

    @capacity *= 2
    clear()

    old_buckets.each do |bucket|
      next if bucket.nil?

      key = bucket[0]
      value = bucket[1]

      set(key, value)
    end
  end

end
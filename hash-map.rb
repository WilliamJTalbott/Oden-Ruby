require_relative "linked-list"

class HashMap

  def initialize()
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
    @buckets[bucket_index] = @buckets[bucket_index] || LinkedList.new

    current = @buckets[bucket_index].at(0)

    while current
      pair = current.value

      if pair[0] == key
        pair[1] = value
        return
      end

      current = current.next_node
    end

    @buckets[bucket_index].append([key, value])
    @size += 1
    check_load
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
    pairs_in_bucket(@buckets[index(key)]).each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  def has?(key)
    get(key) != nil
  end

  def remove(key)
    bucket = @buckets[index(key)]
    return nil if bucket.nil?

    pair_index = pairs_in_bucket(bucket).index { |pair| pair[0] == key }
    return nil if pair_index.nil?

    removed_pair = bucket.remove_at(pair_index)
    @size -= 1

    removed_pair[1]
  end

  def length()
    return @size
  end

  def clear()
    @buckets = Array.new(@capacity)
    @size = 0
  end

  def keys()
    pairs().map { |pair| pair[0] }
  end

  def values()
    pairs().map { |pair| pair[1] }
  end

  def entries()
    pairs()
  end

  def expand_capacity
    old_buckets = @buckets

    @capacity *= 2
    clear()

    old_buckets.each do |bucket|
      pairs_in_bucket(bucket).each do |key, value|
        set(key, value)
      end
    end
  end

  def pairs()
    pairs = []

    @buckets.each do |bucket|
      pairs += pairs_in_bucket(bucket)
    end

    pairs
  end

  def pairs_in_bucket(bucket)
    pairs = []
    return pairs if bucket.nil?

    current = bucket.at(0)

    while current
      pairs << current.value
      current = current.next_node
    end

    pairs
  end

  def print_data()
    puts "Load Factor : #{@load_factor}"
    puts "Capacity : #{@capacity}"
    puts "Buckets : #{@buckets}"
    puts "Size : #{@size}"
  end

end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.print_data()
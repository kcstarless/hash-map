# 21/03/2024
# Ruby: HashSet

# HashSet class
class HashSet
  LOAD_FACTOR = 0.75
  def initialize
    @capacity = 4
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code %= @capacity
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length

    hash_code
  end

  def grow_rehash
    temp_entries = keys
    @capacity *= 2
    clear
    temp_entries.each { |entry| set(entry) }
  end

  def set(key)
    bucket = hash(key)

    @buckets[bucket] = [key] if @buckets[bucket].nil?

    @buckets[bucket] << key unless @buckets[bucket].include?(key)

    grow_rehash if length >= LOAD_FACTOR * @capacity
  end

  def get(key)
    bucket = hash(key)
    return nil if @buckets[bucket].nil?

    @buckets[bucket].include?(key) ? key : nil
  end

  def has(key)
    bucket = hash(key)
    return false if @buckets[bucket].nil?

    @buckets[bucket].include?(key) ? true : false
  end

  def remove(key)
    bucket = hash(key)
    return nil if @buckets[bucket].nil?

    @buckets[bucket].delete(key)
  end

  def length
    keys.size
  end

  def clear
    @buckets = Array.new(@capacity)
  end

  def keys
    list = []
    @buckets.each do |bucket|
      list << bucket unless bucket.nil?
    end
    list.flatten
  end
end

set = HashSet.new

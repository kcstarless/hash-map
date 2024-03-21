# 16/03/24
# Ruby: Hash Map

require_relative 'linked_list'
# HashMap class
class HashMap
  LOAD_FACTOR = 0.75
  attr_accessor :buckets

  def initialize
    @buckets_size = 4
    @buckets = Array.new(@buckets_size)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code %= @buckets_size
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length

    hash_code
  end

  def has(key)
    bucket = hash(key)
    return false if @buckets[bucket].nil?

    @buckets[bucket].contains_key?(key)
  end

  def grow_rehash
    temp_entries = entries
    @buckets_size *= 2
    clear
    temp_entries.each { |entry| set(entry[0], entry[1]) }
  end

  def set(key, value)
    bucket = hash(key)
    if @buckets[bucket].nil?
      list = LinkedList.new
      list.append(key, value)
      @buckets[bucket] = list
    elsif has(key)
      @buckets[bucket].update(key, value)
    else
      @buckets[bucket].append(key, value)
    end
    grow_rehash if length >= @buckets_size * LOAD_FACTOR
  end

  def get(key)
    bucket = hash(key)
    return nil if @buckets[bucket].nil?

    @buckets[bucket].at_key(key)
  end

  def remove(key)
    bucket = hash(key)
    return nil unless has(key)

    temp = buckets[bucket].at_key(key)
    if buckets[bucket].size == 1
      buckets[bucket] = nil
      return temp
    end

    buckets[bucket].remove_entry(key)
  end

  def length
    keys.length
  end

  def clear
    @buckets = Array.new(@buckets_size)
  end

  def keys
    list = []
    buckets.each { |bucket| list << bucket.all_keys if bucket }
    list.flatten
  end

  def values
    list = []
    buckets.each { |bucket| list << bucket.all_values if bucket }
    list.flatten
  end

  def entries
    list = []
    keys.each { |key| list << [key, get(key)] }
    list
  end
end

# Test
hash = HashMap.new
hash.set('tom', 'the software engineer')
hash.set('tom', 'web desinger')
# hash.set('mot', 'tester')
# hash.set('zen', 'supervsior')
# hash.set('david', 'android')
# hash.set('collin', 'barista')
# hash.set('sam', 'punch bag')
# hash.set('paul', 'security')
puts hash.length
puts hash.get('mot')
puts hash.has('tom')
# puts hash.remove('mot')
puts hash.remove('tom')
puts hash.has('mot')
puts hash.length
# p hash.keys
# p hash.values
p hash.entries

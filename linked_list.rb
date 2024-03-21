# 12/03/24
# Project: Linked-List
# Assignment

### LinkedList contains a head and node
class LinkedList
  def initialize
    @head = nil
  end

  def tail(node = @head)
    return node if node.next_node.nil?

    tail(node.next_node)
  end

  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    tail.next_node = Node.new(key, value)
  end

  def prepend(key, value)
    append(value) if @head.nil?

    node = @head
    @head = Node.new(key, value)
    @head.next_node = node
  end

  def size
    return 0 if @head.nil?

    node = @head
    count = 1
    until node.next_node.nil?
      node = node.next_node
      count += 1
    end
    count
  end

  def first
    return nil if @head.nil?

    @head
  end

  def last
    node = @head
    node = node.next_node until node.next_node.nil?
    node
  end

  def at(index, node = @head, count = 0)
    return `Index out of bound` if index >= size || index.negative?
    return node if count == index

    at(index, node.next_node, count + 1)
  end

  def pop(node = @head)
    return nil if @head.nil?

    if node.next_node.next_node.nil?
      node.next_node = nil
      return node
    end

    pop(node.next_node)
  end

  def contains?(value, node = @head)
    return true if node.value == value
    return false if node.next_node.nil?

    contains?(value, node.next_node)
  end

  def find(value, node = @head, count = 0)
    return count if node.value == value
    return nil if node.next_node.nil?

    find(value, node.next_node, count + 1)
  end

  def to_s(node = @head, list = '')
    return nil if @head.nil?
    return list + "(#{node.value}) -> nil" if node.next_node.nil?

    to_s(node.next_node, list + "(#{node.value}) -> ")
  end

  def insert_at(value, index)
    return prepend(value) if index.zero?

    node = Node.new(value)
    node.next_node = at(index)
    at(index - 1).next_node = node
  end

  def remove_at(index)
    return 'Index is out of range!' if index >= size || index.negative?

    removed_node = at(index)

    if index.zero?
      shift
    elsif index == size - 1
      pop
    else
      at(index - 1).next_node = at(index + 1)
    end
    removed_node
  end


  ### All hash_map methods
  def update(key, value, node = @head)
    return nil if node.nil?
    return node.value = value if key == node.key

    update(key, value, node.next_node)
  end

  def at_key(key, node = @head)
    return nil if node.nil?
    return node.value if key == node.key

    at_key(key, node.next_node)
  end

  def contains_key?(key, node = @head)
    return true if node.key == key
    return false if node.next_node.nil?

    contains_key?(key, node.next_node)
  end

  def remove_entry(key, node = @head, counter = 0)
    if key == node.key && counter.zero?
      return shift
    elsif key == node.key && counter == size - 1
      pop
      return node.value
    elsif counter >= 2 && key == node.key
      at(counter - 1).next_node = at(counter + 1)
    end

    remove_entry(key, node.next_node, counter + 1)
  end

  def all_keys(node = @head, keys = [])
    keys << node.key
    return keys if node.next_node.nil?

    all_keys(node.next_node, keys)
  end

  def all_values(node = @head, keys = [])
    keys << node.value
    return keys if node.next_node.nil?

    all_keys(node.next_node, keys)
  end
end

### A Node contains value and next node
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

# Test
# new_list = LinkedList.new
# new_list.append(5)
# new_list.append(10)
# new_list.append(20)
# new_list.append(40)
# new_list.prepend(4)
# new_list.prepend(3)
# new_list.insert_at(60, 2)
# new_list.remove_at(6)
# # puts new_list.last.value
# puts new_list

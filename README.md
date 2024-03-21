# Ruby: hash-map & hash-set

## 1. Description
Re-using previous project linked-list. I have adpoted hash-map set without using any built in ruby #hash. Hash-map contian key value pairs stored as linked list node while hash-set is simple array that stores keys only. 

## 2. Hash algorithm
Hash key is achieved by using has algorithm and using prime number as follow:
``` hash_code = prime_number * hash_code + char.ord ```
where #prime_number in this case used #31. Index number is achieved by using modulo operation of capacity where capacity is the size of an hash-map. 
``` bucket = hash_code % @capacity ```

## 3. Usage
This hash-map class have following methods: 
1. #hash(key) takes a key and produces a hash code with it. We did implement a fairly good hash method in the previous lesson. As a reminder:
2. set(key, value) takes two arguments, the first is a key and the second is a value that is assigned to this key. If a key already exists, then the old value is overwritten or we can say that we update the key’s value.
3. #get(key) takes one argument as a key and returns the value that is assigned to this key. If key is not found, return nil.
4. #has(key) takes a key as an argument and returns true or false based on whether or not the key is in the hash map.
5. #remove(key) takes a key as an argument. If the given key is in the hash map, it should remove the entry with that key and return the deleted entry’s value. If the key isn’t in the hash map, it should return nil.
6. #length returns the number of stored keys in the hash map.
7. #clear removes all entries in the hash map.
8. #keys returns an array containing all the keys inside the hash map.
9. #values returns an array containing all the values.
10. #entries returns an array that contains each key, value pair. Example: [[first_key, first_value], [second_key, second_value]]

## 4. Thought on the project
Understanding how key is setup was little confusing but after understanding that hash-key is the index (#bucket) it made more sense. By using linked list I've eliminated the collision and duplicate data being stored of same hash-key value. 
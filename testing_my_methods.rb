$LOAD_PATH << '.'       # this is used instead of require_relative
require 'my_methods'
include Enumerable      # you can include a module in a class

a = [ "a", "b", "c" ]
a.my_each {|x| print x, " -- " }

hash = Hash.new
%w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
}
p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

p [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

p %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true

p %w[ant bear cat cs].all? { |word| word.length >= 3 } #=> false
p %w[ant bear cat cs].my_all? { |word| word.length >= 3 } #=> false

p [nil, true, 99].all?                              #=> false
p [nil, true, 99].my_all?                              #=> false
p [true, 99].all?                              #=> true
p [true, 99].my_all?                              #=> true

p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
p %w[an be cat].any? { |word| word.length >= 3 } #=> true
p %w[an be ca].any? { |word| word.length >= 3 } #=> false

p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[an be cat].my_any? { |word| word.length >= 3 } #=> true
p %w[an be ca].my_any? { |word| word.length >= 3 } #=> false

p [nil, true, 99].any?                              #=> true
p [nil, true, 99].my_any?                              #=> true
p [true, 99].any?                              #=> true
p [true, 99].my_any?                              #=> true

p [].my_any? #=> false
p [].my_all? #=> true

p %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
p [].none?                                           #=> true
p [nil, false].none?                                 #=> true
p [nil, false].none?                                 #=> true
p [nil, false, true].none?                           #=> false

p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p [].my_none?                                           #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false

ary = [1, 2, 4, 2]
p ary.count               #=> 4
p ary.count(2)            #=> 2
p ary.count{ |x| x%2==0 } #=> 3

p ary.my_count               #=> 4
p ary.my_count(2)            #=> 2
p ary.my_count{ |x| x%2==0 } #=> 3

p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

p [1,2,3,4].my_map { |i| i*i }      #=> [1, 4, 9, 16]
p [1,2,3,4].my_collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

my_arr = []
(5..10).each {|i| my_arr << i}

p my_arr.inject { |sum, n| sum + n }      #=> 45
p my_arr.my_inject { |sum, n| sum + n }   #=> 45

longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end
p longest                                 #=> 'sheep'

def multiply_els(my_arr)
  my_arr.my_inject { |mult, n| mult * n }
end

p multiply_els([2,4,5])                     #=> 40

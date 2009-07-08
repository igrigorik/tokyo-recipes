require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978) 
 
puts t.ext(:put, '123', 'hello world')
puts t.ext(:put, '124', 'world of icecream')

puts t.ext(:search, 'world', 5)
 
t.close

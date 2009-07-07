require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978) 
 
puts t.ext(:add, 1, 123); sleep 1
puts t.ext(:add, 1, 253); sleep 1
puts t.ext(:add, 1, 343); sleep 1
puts t.ext(:add, 2, 123); sleep 1

puts t.ext(:list, 1, '') 

t.close

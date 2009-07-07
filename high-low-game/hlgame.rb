require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978) 
 
puts t.ext(:start, 'ilya', 10000)
puts t.ext(:high, 'ilya', 2000)
puts t.ext(:low, 'ilya', 2000) 
   
t.close

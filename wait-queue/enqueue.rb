require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978)  
puts t.ext(:enqueue, 'foo', 'bar') 
   
t.close

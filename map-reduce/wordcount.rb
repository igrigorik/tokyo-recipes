require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978)  

t['1'] = "hello world"
t['2'] = "what a beautiful world"
t['3'] = "hello bob"

puts t.ext(:wordcount, '', '') 
   
t.close

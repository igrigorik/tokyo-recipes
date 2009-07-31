require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978)  

t.ext('eval', 'function hello() return "hello" end', '')
puts t.ext(:hello, '', '')

t.ext('eval', 'function hello() return "bye" end', '')
puts t.ext(:hello, '', '')

t.close

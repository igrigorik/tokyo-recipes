require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  
   
t = Rufus::Tokyo::Tyrant.new('127.0.0.1', 1978)  
   
5.times do  
  puts t.ext(:incr, 'my-counter', 2).to_i  
end  
   
t.close

__END__

[ilya@igvita increment-command]# ruby ruby-incr.rb 
2
4
6
8
10

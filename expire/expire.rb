require 'rubygems'
require 'rufus/tokyo/tyrant' # sudo gem install rufus-tokyo  

t = Rufus::Tokyo::TyrantTable.new('127.0.0.1', 1978)

t['key1'] = { 'name' => 'alfred', 'x' => (Time.now.to_i + 2).to_s }
t['key2'] = { 'name' => 'bob', 'x' => (Time.now.to_i + 5).to_s }

sleep(3)

p t['key1'] # expired
p t['key2'] # valid

t.close

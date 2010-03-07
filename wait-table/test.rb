# start tyrant like so:
# ttserver example.tct
require 'rubygems'
require 'tokyo_tyrant'
require 'pp'
t = TokyoTyrant::Table.new('127.0.0.1', 1978)


# bulk operations
h = {}
h[0] = { :name => 'A: Joe task one', :region => 'us', :priority => 2, :url => 'http://example.com/0', :status => 'new'}
h[1] = { :name => 'B: Bob task one', :region => 'us', :priority => 2, :url => 'http://example.com/1', :status => 'new'}
h[2] = { :name => 'C: Joe task two', :region => 'us', :priority => 2, :url => 'http://example.com/2', :status => 'new'}
h[3] = { :name => 'D: Bob task two', :region => 'eu', :priority => 1, :url => 'http://example.com/3', :status => 'new'}
h[4] = { :name => 'E: Bob task three', :region => 'us', :priority => 1, :url => 'http://example.com/3', :status => 'new'}

t.mput(h)
# t.mget(0..3)

p  "Fetch only new tasks"
# q = t.query
#   q.condition('status', :streq, 'new')
#   q.limit(1)
# p  q.get 
# # =>   [{"name"=>"A: Joe task one", "region"=>"us", "priority"=>"2", "url"=>"http://example.com/0", "__id"=>"0", "status"=>"new"}]
p "Changing to pending"
p t.ext(:update_new_task, 1, 2)


p "Fetch only new tasks order by priority"
# q = t.query
#   q.condition('status', :streq, 'new')
#   q.order_by(:priority, :strasc)
#   q.limit(1)
# p  q.get
# => [{"name"=>"D: Bob task two", "region"=>"eu", "priority"=>"1", "url"=>"http://example.com/3", "__id"=>"3", "status"=>"new"}]

p "Changing to pending"
p t.ext(:priority, 1, 2)

p "Fetch only Bob's US new tasks"
# q = t.query
#   q.condition('status', :streq, 'new')
#   q.condition('region', :streq, 'us')
#   q.condition('name', :strinc, 'Bob')
#   q.limit(1)
# p q.get
# => [{"name"=>"B: Bob task one", "region"=>"us", "priority"=>"2", "url"=>"http://example.com/1", "__id"=>"1", "status"=>"new"}]

p "Changing to pending"
p t.ext(:combo, 1, 2)
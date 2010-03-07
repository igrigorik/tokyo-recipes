-- queue.lua example is from Tokyo Tyrant source code
--
-- Queue mechanism by the Lua extension of Tokyo Tyrant
--



----------------------------------------------------------------
-- public functions
----------------------------------------------------------------


-- enqueue a record
function enqueue(key, value)
   local id = _adddouble(key, 1)
   print (key)
   print (value)
   if not id then
      return nil
   end
   key = string.format("%s\t%012d", key, id)
   if not _putkeep(key, value) then
      return "not ok"
   end
   return "ok"
end

-- dequeue a record
function dequeue(key, max)
   max = tonumber(max)
   if not max or max < 1 then
      max = 1
   end
   key = string.format("%s\t", key)
   local keys = _fwmkeys(key, max)
   local res = ""
   for i = 1, #keys do
      local key = keys[i]
      local value = _get(key)
      if _out(key) and value then
         res = res .. value .. "\n"
      end
   end
   return res
end

-- get the queue size
function queuesize(key)
   key = string.format("%s\t", key)
   local keys = _fwmkeys(key)
   return #keys
end

-- END OF FILE
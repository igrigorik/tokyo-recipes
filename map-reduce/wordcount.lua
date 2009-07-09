--
-- wordcount map-reduce 
--

function wordcount()
   function mapper(key, value, mapemit)
      for word in string.gmatch(string.lower(value), "%w+") do
         mapemit(word, 1)
      end
      return true
   end

   local res = ""
   function reducer(key, values)
      res = res .. key .. "\t" .. #values .. "\n"
      return true
   end

   if not _mapreduce(mapper, reducer) then
      res = nil
   end
   return res
end

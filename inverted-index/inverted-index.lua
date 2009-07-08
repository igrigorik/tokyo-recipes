--
-- Inverted index by the Lua extension of Tokyo Tyrant
--


-- constants
DELIMS = " \t\r\n"   -- delimiters of tokenizing
LIMNUM = 2000        -- limit number of kept occurrence
DEFMAX = 10          -- default maximum number of search


-- call back function when starting
function _begin()
   _log("Inverted index started")
end

-- call back function when ending
function _end()
   _log("Inverted index finished")
end

-- register a text into the index
function put(id, text)
   id = tonumber(id)
   if not id or id < 1 then
      return nil
   end
   if not text then
      return nil
   end
   local tokens = _tokenize(text)
   if math.random() < 5 / LIMNUM then
      for i = 1, #tokens do
         token = tokens[i]
         if not _lock(token) then
            _log("lock error")
            return nil
         end
         local ids = {}
         local idsel = _get(token)
         if idsel then
            ids = _unpack("w*", idsel)
         end
         local nids = {}
         local top = #ids - LIMNUM + 2
         if top < 1 then
            top = 1
         end
         for j = top, #ids do
            table.insert(nids, ids[j])
         end
         table.insert(nids, id)
         idsel = _pack("w*", nids)
         if not _put(token, idsel) then
            _log("put error")
            _unlock(token)
            return nil
         end
         _unlock(token)
      end
   else
      local idsel = _pack("w", id)
      for i = 1, #tokens do
         token = tokens[i]
         if not _lock(token) then
            _log("lock error")
            return nil
         end
         if not _putcat(token, idsel) then
            _log("putcat error")
            _unlock(token)
            return nil
         end
         _unlock(token)
      end
   end
   return "ok"
end

-- remove a text from the index
function out(id, text)
   id = tonumber(id)
   if not id or id < 1 then
      return nil
   end
   if not text then
      return nil
   end
   local tokens = _tokenize(text)
   for i = 1, #tokens do
      token = tokens[i]
      if not _lock(token) then
         _log("lock error")
         return nil
      end
      local ids = {}
      local idsel = _get(token)
      if idsel then
         ids = _unpack("w*", idsel)
      end
      local nids = {}
      for j = 0, #ids do
         if ids[j] ~= id then
            table.insert(nids, ids[j])
         end
      end
      idsel = _pack("w*", nids)
      if not _put(token, idsel) then
         _log("put error")
         _unlock(token)
         return nil
      end
      _unlock(token)
   end
   return "ok"
end

-- replace the text
function replace(id, befaft)
   id = tonumber(id)
   if not id or id < 1 then
      return nil
   end
   if not befaft then
      return nil
   end
   local pivot = string.find(befaft, "\n", 1, true)
   if not pivot then
      return nil
   end
   local bef = string.sub(befaft, 1, pivot - 1)
   local aft = string.sub(befaft, pivot + 1)
   if not out(id, bef) then
      return nil
   end
   if not put(id, aft) then
      return nil
   end
   return "ok"
end

-- search the index with a phrase of intersection
function search(phrase, max)
   if not phrase then
      return nil
   end
   max = tonumber(max)
   if not max or max < 0 then
      max = DEFMAX
   end
   local tokens = _tokenize(phrase)
   local tnum = #tokens
   if tnum < 1 then
      return "0\n"
   end
   local idsel = _get(tokens[1])
   local result = _unpack("w*", idsel)



   for i = 2, tnum do
      idsel = _get(tokens[i])
      local ids = _unpack("w*", idsel)
      result = _isect(result, ids)
   end




--   if tnum > 1 then
--      local rset = {}
--      table.insert(rset, result)
--      for i = 2, tnum do
--	 idsel = _get(tokens[i])
--	 result = _unpack("w*", idsel)
--	 table.insert(rset, result)
--      end
--      result = _isect(rset)
--   end



   table.sort(result)
   local rtxt = #result .. "\n"
   local bot = #result - max
   if bot < 1 then
      bot = 1
   end
   for i = #result, bot, -1 do
      if max < 1 then
         break
      end
      rtxt = rtxt .. result[i] .. "\n"
      max = max - 1
   end
   return rtxt
end

-- break a text into an array of tokens
function _tokenize(text)
   local tokens = {}
   local uniq = {}
   for token in string.gmatch(text, "[^" .. DELIMS .. "]+") do
      if #token > 0 and not uniq[token] then
         table.insert(tokens, token)
         uniq[token] = true
      end
   end
   return tokens
end

-- END OF FILE

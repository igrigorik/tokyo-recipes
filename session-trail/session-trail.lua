MAXPRINT = 60

function add(key, value)
   key = tonumber(key)
   value = tonumber(value)
   if not key or not value or key == value then
      return nil
   end
   local ksel = _pack("i", key)
   local time = os.time()
   local date = os.date("*t", time)
   date.hour = 0
   date.min = 0
   date.sec = 0
   local mintime = os.time(date)
   local vsel
   local ary = _unpack("i*", _get(ksel))
   local anum = 1
   if ary and #ary > 0 then
      local nary = {}
      local nidx = 1
      local nidxmax = MAXPRINT * 2 - 1
      for i = 1, #ary, 2 do
         if ary[i] ~= value or ary[i+1] < mintime then
            nary[nidx] = ary[i]
            nary[nidx+1] = ary[i+1]
            nidx = nidx + 2
         end
      end
      vsel = _pack("i*", nary, value, time)
      anum = (#nary / 2) + 1
      if anum > MAXPRINT then
         vsel = string.sub(vsel, MAXPRINT * -8)
         anum = MAXPRINT
      end
   else
      vsel = _pack("ii", value, time)
   end
   if not _put(ksel, vsel) then
      return nil
   end
   return anum
end

function list(key, value)
   key = tonumber(key)
   value = tonumber(value)
   if not key then
      return nil
   end
   if not value or value < 1 then
      value = MAXPRINT
   end
   local result = ""
   local ksel = _pack("i", key)
   local ary = _unpack("i*", _get(ksel))
   if ary and #ary > 0 then
      for i = #ary - 1, 0, -2 do
         if value < 1 then
            break
         end
         result = result .. ary[i] .. "\t" .. ary[i+1] .. "\n"
         value = value - 1
      end
   end
   return result
end

function expire()
   local args = {}
   local cdate = string.format("%d", _time())
   table.insert(args, "addcond\0x\0NUMLE\0" .. cdate)
   table.insert(args, "out")
   local res = _misc("search", args)
   if not res then
      _log("expiration was failed")
   end
   print("rnum=" .. _rnum() .. "  size=" .. _size())
end


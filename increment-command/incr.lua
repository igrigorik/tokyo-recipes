-- 
-- incr.lua
--  
function incr (key, i)  
  i = tonumber(i)  
  if not i then  
   return nil  
  end  

  local old = tonumber(_get(key))  
  if old then  
    i = old + i  
  end  

  if not _put(key, i) then  
    return nil  
  end  

  return i  
end  

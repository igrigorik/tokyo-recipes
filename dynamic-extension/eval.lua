-- 
-- eval.lua
--  

function eval(key, value)
   if not _eval(key) then
      return nil
   end
   return "ok"
end

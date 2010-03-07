-- Equivalent to this sql
-- update table set status ="pending" where status = "new" limit 1
function update_new_task()
  -- body
  local args = {};
  table.insert(args, "addcond\0status\0streq\0new")
  table.insert(args, "setlimit\01")
  table.insert(args, "columns")
  local res = _misc("search", args)
  if not res then
     _log("failed", 2)
  end
  for key,value in pairs(res) do
    print(":"..tostring(key).."="..tostring(value)..":")
  end
  -- The below is not working because re[1] is empty
  -- return _strstr(res[1], "new", "pending")
  return res[1]
end

function priority()
  -- body
  local args = {};
  table.insert(args, "addcond\0status\0streq\0new")
  table.insert(args, "setorder\0priority\0strasc")
  table.insert(args, "setlimit\01")
  table.insert(args, "columns")
  
  
  local res = _misc("search", args)
  if not res then
     _log("failed", 2)
  end
  return res[1]
end

function combo()
  -- body
  local args = {};
  
  table.insert(args, "addcond\0status\0streq\0new")
  table.insert(args, "addcond\0region\0streq\0us")
  table.insert(args, "addcond\0name\0strinc\0Bob")
  table.insert(args, "setlimit\01")
  table.insert(args, "columns")
  
  local res = _misc("search", args)
  if not res then
     _log("failed", 2)
  end
  return res[1]
end

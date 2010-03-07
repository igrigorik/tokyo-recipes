-- Equivalent to this sql
-- update table set status ="pending" where status = "new" limit 1
-- const void *pkbuf, int pksiz, TCMAP *cols, void *op
function pending(pkey, cols)
  _log("at pending callback")
  _log(pkey)
  _log(cols)
  local status = _misc("tcmapget2", cols, "status");
  if not status then
     _log("failed to get status", 2)
  end
  
  _misc("tcmapput2", cols, "status", "pending");
  return TDBQPPUT;
end

function update_new_task()
  _log("updating new task")
  local args = {};
  table.insert(args, "addcond\0status\0streq\0new")
  table.insert(args, "setlimit\01")
  table.insert(args, "columns")
  _misc("proc", args, pending)
  
  res = _misc("search", args)
  
  if not res then
     _log("failed misc", 2)
  end
  return res[1]
end

function update_new_task_2()
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
  local new_value = return _strstr(res[1], "new", "pending")
  _misc("putlist", new_value)

  res = _misc("search", args)
  
  if not res then
     _log("failed misc", 2)
  end
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

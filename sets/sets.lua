-----------------------------------------------------------------------------
-- Tokyo Tyrant Set Operations (by  Eivind Uggedal)
-- http://github.com/uggedal/tokyo-tyrant-sets/blob/f28b61e7c9e5aaa7282b9ef1c1bc81c48e806e6d/set.lua
-----------------------------------------------------------------------------
 
local SEP = '\n'
 
function _set_len(stream)
  local count = 0
  if stream then
    count = table.getn(_split(stream, SEP))
  end
  return count
end
 
function set_length(key, value)
  return _set_len(_get(key))
end

function set_get(key)
	return _get(key)
end
 
function set_append(key, value)
  local stream = _get(key)
 
  if not stream then
    _put(key, value)
  else
    local set_len = _set_len(stream)
 
    if set_len == 1 then
      if stream == value then return nil end
    elseif set_len > 1 then
      for _, element in ipairs(_split(stream, SEP)) do
        if element == value then return nil end
      end
    end
    if not _putcat(key, SEP .. value) then
      return nil
    end
  end
  return value
end
 
function set_delete(key, value)
  local stream = _get(key)
 
  if stream then
    local set_len = _set_len(stream)
 
    if set_len == 1 and stream == value then
      if _out(key) then return value end
    elseif set_len > 1 then
      local found = -1
      local set_list = _split(stream, SEP)
 
      for i, element in ipairs(set_list) do
        if element == value then
          found = i
          break
        end
      end
 
      if found > -1 then
        table.remove(set_list, found)
        if _put(key, table.concat(set_list, SEP)) then return value end
      end
    end
  end
  return nil
end

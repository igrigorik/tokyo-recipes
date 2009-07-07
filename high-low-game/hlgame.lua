NUMRANGE = 100
MAXROUND = 5
math.randomseed(os.time())

function start(key, value)
   value = tonumber(value)
   if not value or value <= 0 then
      return "error: invalid value"
   end
   if not _putkeep(key .. ":r", 1) then
      return "error: already started"
   end
   local num = math.random(NUMRANGE)
   _put(key .. ":m", value)
   _put(key .. ":n", num)
   return "Welcome, " .. key .. ".\n" ..
      "The current number is " .. num .. ".\n" ..
      "Your money is " .. value .. ".\n" ..
      "Round 1 Bet!\n"
end

function high(key, value)
   return do_bet(key, value, true)
end

function low(key, value)
   return do_bet(key, value, false)
end

function over(key, value)
   if _vsiz(key .. ":r") < 0 then
      return "error: not started"
   end
   _out(key .. ":r")
   _out(key .. ":m")
   _out(key .. ":n")
   return "Good Bye!"
end

function do_bet(key, value, ishigh)
   value = tonumber(value)
   if not value or value <= 0 then
      return "error: invalid value"
   end
   local round = tonumber(_get(key .. ":r"))
   if not round then
      return "error: not started"
   end
   local money = tonumber(_get(key .. ":m"))
   if round > MAXROUND or money < 1 then
      return "error: already finished"
   end
   if value > money then
      value = money
   end
   local num = tonumber(_get(key .. ":n"))
   local newnum = math.random(NUMRANGE)
   local cmp = "even"
   local res = "lost"
   if newnum > num then
      cmp = "high"
      if ishigh then
         res = "won"
      end
   elseif newnum < num then
      cmp = "low"
      if not ishigh then
         res = "won"
      end
   end
   round = round + 1
   if res == "won" then
      money = money + value
   else
      money = money - value
   end
   _put(key .. ":r", round)
   _put(key .. ":m", money)
   _put(key .. ":n", newnum)
   local call = "Round " .. round .. " Bet!\n"
   if round > MAXROUND or money < 1 then
      call = "Game Over!\n"
   end
   return "The current number is " .. newnum .. ".\n" ..
      newnum .. ":" .. num .. " (" .. cmp .. ") ... You " .. res .. "!\n" ..
      "Your money is " .. money .. ".\n" ..
      call
end


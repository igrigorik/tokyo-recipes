require "queue"

function wait_queue(key, max)
  r = ""
  repeat 
    sleep(0.1)
    r = dequeue(key, max) 
  until (r ~= "")

  return r
end

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end
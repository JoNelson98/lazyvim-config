local M = {}

local function choose(x)
  if x % 15 == 0 then
    return "fizzbuzz"
  elseif x % 3 == 0 then
    return "fizz"
  elseif x % 5 == 0 then
    return "buzz"
  else
    return x
  end
end

local function try_div(a, b)
  local ok, r = pcall(function()
    return a / b
  end)
  if ok then
    return r
  else
    return "err"
  end
end

local function parse(line)
  local t = {}
  for k, v in line:gmatch "(%w+)=([%w_%-%.]+)" do
    t[k] = v
  end
  return t
end

local function expand(s, env)
  return (s:gsub("%${([%w_]+)}", function(k)
    return tostring(env[k] or "")
  end))
end

local function run(n, line, fmt)
  n = n or 12
  local env = { who = "you", n = n }
  local t, sum, evens = {}, 0, 0
  for i = 1, n do
    local v = i
    if v % 2 == 0 then
      evens = evens + 1
    end
    sum = sum + v
    t[i] = choose(v)
  end

  local co = coroutine.create(function(k)
    for i = 1, k do
      coroutine.yield(i, i * i)
    end
  end)
  local ok, a, b = coroutine.resume(co, math.min(n, 7))
  local co_out = ok and { a = a, b = b } or {}

  local div_ok = try_div(n, n - n)
  local parsed = parse(line or "a=1 b=two_c c=3")
  local text = expand(fmt or "hello ${who} #${n}", env)

  if sum % 2 == 0 then
    return {
      ok = true,
      sum = sum,
      evens = evens,
      first = t[1],
      last = t[#t],
      co = co_out,
      div = div_ok,
      parsed = parsed,
      text = text,
    }
  elseif evens > n / 2 then
    return { ok = false, reason = "evens", sum = sum, pick = t[2], co = co_out, div = div_ok }
  else
    return { ok = false, reason = "odd", sum = sum, pick = t[3], co = co_out, div = div_ok }
  end
end

M.run = run
return M

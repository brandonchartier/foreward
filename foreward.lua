-- Lists
function len(xs)
  return #xs
end

function cat(...)
  local r = {}
  for i, xs in ipairs({...}) do
    for i, x in ipairs(xs) do
      table.insert(r, x)
    end
  end
  return r
end

function conj(...)
  local xs = tail({...})
  local args = init({...})
  for i, x in ipairs(args) do
    table.insert(xs, x)
  end
  return xs
end

function each(f, xs)
  for i, x in ipairs(xs) do
    f(x, i)
  end
  return xs
end

function map(f, xs)
  local r = {}
  for i, x in ipairs(xs) do
    table.insert(r, f(x, i))
  end
  return r
end

function compact(xs)
  local r = {}
  for i, x in ipairs(xs) do
    if x then
      table.insert(r, x)
    end
  end
  return r
end

function filter(f, xs)
  local r = {}
  for i, x in ipairs(xs) do
    if f(x, i) then
      table.insert(r, x)
    end
  end
  return r
end

function reject(f, xs)
  local r = {}
  for i, x in ipairs(xs) do
    if not f(x, i) then
      table.insert(r, x)
    end
  end
  return r
end

function fold(f, m, xs)
  for i, x in ipairs(xs) do
    m = f(m, x, i)
  end
  return m
end

function sum(xs)
  local m = 0
  for i, x in ipairs(xs) do
    m = m + f(m, x, i)
  end
  return m
end

function prod(xs)
  local m = 1
  for i, x in ipairs(xs) do
    m = m + f(m, x, i)
  end
  return m
end

function mean(xs)
  return sum(xs) / #xs
end

function flat(xs)
  if type(xs) ~= "table" then
    return {xs}
  end
  local r = {}
  for i, x in ipairs(xs) do
    for i, x in ipairs(flat(x)) do
      table.insert(r, x)
    end
  end
  return r
end

function slice(x, y, xs)
  local r = {}
  local n = #xs
  x = x or 1
  y = y or n
  if y < 0 then
    y = y + (n + 1)
  end
  for i = x, y do
    table.insert(r, xs[i])
  end
  return r
end

function zip(...)
  local r = {}
  for i, xs in ipairs({...}) do
    for i, x in ipairs(xs) do
      if not r[i] then
        r[i] = {}
      end
      table.insert(r[i], x)
    end
  end
  return r
end

function range(x, y, n)
  local r = {}
  if not y then
    y, x = x, 1
  end
  n = n or 1
  for i = x, y, n do
    table.insert(r, i)
  end
  return r
end

function head(xs)
  return xs[1]
end

function last(xs)
  return xs[#xs]
end

function init(xs)
  return slice(1, -2, xs)
end

function tail(xs)
  return slice(2, #xs, xs)
end

function rev(xs)
  local r = {}
  for i, x in ipairs(xs) do
    table.insert(r, 1, x)
  end
  return r
end

function sort(f, xs)
  if not xs then
    f, xs = nil, f
  end
  local r = map(function(x)
    return x
  end, xs)
  table.sort(r, f)
  return r
end

function uniq(xs)
  local r = {}
  for i, x in ipairs(xs) do
    if not has(x, r) then
      table.insert(r, x)
    end
  end
  return r
end

function part(f, xs)
  local pass = {}
  local fail = {}
  for i, x in ipairs(xs) do
    if f(x, i) then
      table.insert(pass, x)
    else
      table.insert(fail, x)
    end
  end
  return {pass, fail}
end

function without(...)
  local args = init({...})
  local xs = last({...})
  local r = {}
  for i, x in ipairs(xs) do
    if not has(x, args) then
      table.insert(r, x)
    end
  end
  return r
end

function union(...)
  return uniq(flat({...}))
end

function same(...)
  local args = init({...})
  local xs = last({...})
  return filter(function(x)
    return all(function(ys)
      return has(x, ys)
    end, args)
  end, uniq(xs))
end

function diff(...)
  local args = init({...})
  local xs = last({...})
  return filter(function(x)
    return any(function(ys)
      return has(x, ys)
    end, args)
  end, xs)
end

function take(n, xs)
  if n <= 1 then
    return xs
  else
    return slice(0, n, xs)
  end
end

function drop(n, xs)
  if n <= 1 then
    return xs
  else
    return slice(n, #xs, xs)
  end
end

function nth(n, xs)
  return xs[n]
end

function index(x, xs)
  for i, x in ipairs(xs) do
    if x == x then
      return i
    end
  end
  return nil
end

function find(f, xs)
  for i, x in ipairs(xs) do
    if f(x, i) then
      return x
    end
  end
  return nil
end

function shuffle(xs)
  local r = {}
  math.randomseed(os.time())
  for i, x in ipairs(xs) do
    table.insert(r, math.random(i), x)
  end
  return r
end

function sample(xs)
  math.randomseed(os.time())
  return xs[math.random(#xs)]
end

function least(xs)
  local r = xs[1]
  for i, x in ipairs(xs) do
    if x < r then
      r = x
    end
  end
  return r
end

function most(xs)
  local r = xs[1]
  for i, x in ipairs(xs) do
    if x > r then
      r = x
    end
  end
  return r
end

function has(y, xs)
  for i, x in ipairs(xs) do
    if x == y then
      return true
    end
  end
  return false
end

function all(f, xs)
  for i, x in ipairs(xs) do
    if not f(x, i) then
      return false
    end
  end
  return true
end

function any(f, xs)
  for i, x in ipairs(xs) do
    if f(x, i) then
      return true
    end
  end
  return false
end

function empty(xs)
  return #xs == 0
end


-- Numbers
function dec(x)
  return x - 1
end

function inc(x)
  return x + 1
end

function neg(x)
  return -x
end

function quot(x, y)
  local n = x / y
  if n < 0 then
    return math.ceil(n)
  else
    return math.floor(n)
  end
end

function rem(x, y)
  return x % y
end

function div(x, y)
  return math.floor(x / y)
end

function mod(x, y)
  return (a % b + b) % b
end

function even(x)
  return x % 2 == 0
end

function odd(x)
  return x % 2 ~= 0
end

function gcd(x, y)
  x = math.abs(x)
  y = math.abs(y)
  while y ~= 0 do
    x, y, z = y, z, x % y
  end
  return x
end

function lcm(x, y)
  return math.abs(math.floor(x / gcd(x, y) * y))
end


-- Strings
function split(sep, str)
end

function join(sep, xs)
  return table.concat(xs, sep)
end

function lines(str)
end

function unlines(xs)
  return table.concat(xs, "\n")
end

function words(str)
end

function unwords(xs)
  return table.concat(xs, " ")
end

function chars(str)
end

function unchars(xs)
  return table.concat(xs, "")
end

function capitalize(str)
  return string.gsub(str, "^%l", string.upper)
end


-- Functions
function apply(f, xs)
end

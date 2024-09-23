local arg = { ... }
local d1, d2, newArg, mathInput, cOut
_, _, d1, mathInput, d2, newArg = string.find(arg[1], "([+-]?%d*)(.)([+-]?%d+)(.*)")
if mathInput == "+" then
    cOut = (tonumber(d1) + tonumber(d2))
elseif mathInput == "-" then
    cOut = (tonumber(d1) - tonumber(d2))
elseif mathInput == "*" then
    cOut = (tonumber(d1) * tonumber(d2))
elseif mathInput == "/" then
    cOut = (tonumber(d1) / tonumber(d2))
end
-- print("Input num 1: "..d1)
-- print("Input Math Sym: "..mathInput)
-- print("Input num 2: "..d2)
-- print("Current Output Value: "..cOut)
-- print("Remaining Args: "..newArg)
while true do
    if newArg == nil then
        break
    end
    _, _, mathInput, d2, newArg = string.find(newArg, "(.)([+-]?%d+)(.*)")
    -- print("in loop d2:"..d2)
    -- print("cOut pre op: "..cOut)
    if mathInput == "+" then
        -- print("d2: "..d2)
        -- print("cOut: "..cOut)
        cOut = (cOut + tonumber(d2))
        -- print("MATH cOut: "..cOut)
    elseif mathInput == "-" then
        cOut = (cOut - tonumber(d2))
    elseif mathInput == "*" then
        cOut = (cOut * tonumber(d2))
    elseif mathInput == "/" then
        cOut = (cOut / tonumber(d2))
    else
        break
    end
    -- print("new math: "..mathInput)
    -- print("cOut: "..cOut)
end
print("Result: " .. cOut)

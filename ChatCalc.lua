write(">")
local spininput = read()
local t1,t2,t3
local Result = 0
-- _, _, d1, mathInput, d2, newArg = string.find(arg[1], "([+-]?%d*)(.)([+-]?%d+)(.*)")

function _G.Calculatorss(i)
    while true do
        local temp1,temp2, a,b,c
        a,b = string.find(i,"%b()")
        if a == nil then
            i = Calc(i)
            return i
        else
            c= string.sub(i,a+1,b-1)
            temp1 = string.sub(i,1,a-1)
            temp2 = string.sub(i,b+1)
            c = Calc(c)
            i = temp1..c..temp2
        end
    end
end

function _G.Calcss(input)
    local digit, cType
    local cResult = 0
    _, _, cResult, input = string.find(input,"([+-]?%d*)(.*)")
    while input ~= "" do
        cType = string.sub(input,1,1)
        input = string.sub(input,2)
        _, _, digit, input = string.find(input,"([+-]?%d*)(.*)")
        if cType == "+"then
            cResult = cResult+digit
        elseif cType == "-"then
            cResult = cResult-digit
        elseif cType == "*"then
            cResult = cResult*digit
        elseif cType == "/" or cType == "\\"then
            cResult = cResult/digit
        elseif cType == "^"then
            cResult = cResult^digit
        end
    end
    return cResult
end

Result = Calculator(spininput)
print(Result)



-- if mathInput == "+" then
--     cOut = (tonumber(d1) + tonumber(d2))
-- elseif mathInput == "-" then
--     cOut = (tonumber(d1) - tonumber(d2))
-- elseif mathInput == "*" then
--     cOut = (tonumber(d1) * tonumber(d2))
-- elseif mathInput == "/" then
--     cOut = (tonumber(d1) / tonumber(d2))
-- end
-- while true do
--     if newArg == nil then
--         break
--     end
--     _, _, mathInput, d2, newArg = string.find(newArg, "(.)([+-]?%d+)(.*)")
--     if mathInput == "+" then
--         cOut = (cOut + tonumber(d2))
--     elseif mathInput == "-" then
--         cOut = (cOut - tonumber(d2))
--     elseif mathInput == "*" then
--         cOut = (cOut * tonumber(d2))
--     elseif mathInput == "/" then
--         cOut = (cOut / tonumber(d2))
--     else
--         break
--     end
-- end

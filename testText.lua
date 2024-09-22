write(">")
local input = read() --Replace with input from chat
local request = http.get("https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Dad%20Commands.txt")
local inputMod = string.lower(input)
local txt = request.readAll()
local a,b,c
-- print(txt)
function TestFunc()
    print('Yippie!')
end

print(inputMod)
a,b = string.find(txt,inputMod)
if a == nil or b == nil then
    error("idiot")
else
    a,b = string.find(txt,"%b{}",b+1)
    print(a,b)
    c = string.sub(txt,a+1,b-1)
    local Scrum = load("return function() "..c.." end",nil,nil,_G)
    local Ok, Scrim = pcall(Scrum)
    print(Ok)
    Scrim()
    -- _G[c]()
end
request.close()
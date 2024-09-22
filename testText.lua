write(">")
local input = read() --Replace with input from chat
local request = http.get("https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Dad%20Commands.txt")
local inputMod = string.lower(input)
local txt = request.readAll()
local a,b
print(inputMod)
a,b = string.find(txt,inputMod)
if a == nil or b == nil then
    error("idiot")
else
    a,b = string.find(txt,"%b{}",b+1)
    print(string.sub(txt,a+1,b-1)) --Replace with output to chat
end
request.close()
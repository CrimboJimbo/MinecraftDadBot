write(">")
local input = read()
local request = http.get("https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Text%20Test.txt")
local inputMod = string.gsub(input, " ", "_")
local txt = request.readAll()
local a,b
a,b = string.find(txt,inputMod)
if a == nil or b == nil then
    error("idiot")
else
    a,b = string.find(txt,"%b{}",b+1)
    print(string.sub(txt,a+1,b-1))
end
request.close()
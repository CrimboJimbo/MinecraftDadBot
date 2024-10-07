local request = http.get(
"https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/DadBotV1.lua")
local file,input
if fs.exists("DadBotV1.lua") then
    print("A version of DadBotV1 has been found")
    print("Delete and re-install? (y\\n)")
    write(">")
    input = io.read()
    if string.lower(input) == "y" then
        fs.delete("DadBotV1.lua")
        file = fs.open("DadBotV1.lua","w")
        file.write(request.readAll())
    else
        error("Install Canceled", 0)
    end
else
    file = fs.open("DadBotV1.lua","w")
    file.write(request.readAll())
end
fs.close()
print("DadBotV1 Installed! Enjoy!")

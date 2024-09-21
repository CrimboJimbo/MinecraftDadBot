local request = http.get("https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Text%20Test.txt")
local a,b = string.find(request,"[iron_golem]")
print(a,b)
request.close()
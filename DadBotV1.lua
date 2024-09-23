local Dad = peripheral.wrap("right")
local newMessage, ss, se, event, username, message, uuid, isHidden
local imCheck = { "i'm ", "i am ", "im " }
Dad.sendMessage("Hello son!", "DadBot", "<>", "&e")

function _G.DadChat(m, t)
    local Dad = peripheral.wrap("right")
    if t == nil then
        Dad.sendMessage(m, "DadBot", "<>", "&e")
    else
        Dad.sendMessageToPlayer(m, t, "Entity", "[]", "&4")
    end
end

function _G.YNChecker(message)
    local yCheck = { "y", "yes", "yup", "you bet" }
    local nCheck = { "n", "no", "nope", "nada", "i do not", "i don't" }
    for k, v in pairs(yCheck) do
        if CheckMessage(message, v) then
            return true
        end
    end
    for k, v in pairs(nCheck) do
        if CheckMessage(message, v) then
            return false
        end
    end
end

function _G.CheckMessage(m, s)
    local a,b
    m = string.lower(m)
    a, b = string.find(m, s)
    if a == nil then
        return false
    else
        return true
    end
end

function _G.DadCommandChecker()
    local request = http.get(
    "https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Dad%20Commands.txt")
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    local inputMod = string.lower(message)
    local txt = request.readAll()
    local a, b, c
    a, b = string.find(txt, inputMod)
    if a == nil or b == nil then
        DadChat("I didn't quite get that.") --Formerly error("idiot")
    else
        a, b = string.find(txt, "%b{}", b + 1)
        print(a, b)
        c = string.sub(txt, a + 1, b - 1)
        _G[c]()
    end
end

function _G.SaveNickNames()
    local file
    if fs.exists("MinecraftDadBot/nicknames.txt") then
        file = fs.open("MinecraftDadBot/nicknames.txt", "r+")
    else
        file = fs.open("MinecraftDadBot/nicknames.txt", "w")
        file.close()
        file = fs.open("MinecraftDadBot/nicknames.txt", "r+")
    end
    DadChat("Alright, What would you like to called?")
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    local names = file.readAll()
    local a, b, c = nil,nil,nil
    if names == nil then
        file.writeLine("["..username.."]".."{"..message.."}")
    else
        a, b = string.find(names, username)
        if a == nil or b == nil then
            file.writeLine("["..username.."]".."{"..message.."}")
        else
            a, b = string.find(names, "%b{}", b + 1)
            c = string.sub(names, a + 1, b - 1)
            os.sleep(1)
            DadChat("You already the the nickname: \""..c.."\"")
            os.sleep(1)
            DadChat("Do you want to change it?")
            event, username, message, uuid, isHidden = os.pullEvent("chat")
            if YNChecker(message) then
                --Temp
                os.sleep(1)
                DadChat("Too bad lmao")
            end
        end
    end
    os.sleep(1)
    DadChat("Alright!")
    file.close()
end

function _G.AskDad()
    DadChat("What would you like to know?")
    local qq = 1
    while qq == 1 do
        event, username, message, uuid, isHidden = os.pullEvent("chat")
        DadChat("I have no Idea.")
        os.sleep(1)
        DadChat("do you have any other questions?")
        event, username, message, uuis, isHidden = os.pullEvent("chat")
        if YNChecker(message) then
            DadChat("What would you like to know?")
        elseif not YNChecker(message) then
            DadChat("Alright!")
            qq = 0
        else
            DadChat("I'll take that as a yes.")
        end
    end
end

function _G.DadWiki() --Wiki function, derived from AskDad()
    DadChat("What would you like to know?")
    local qq = 1
    while qq == 1 do
        event, username, message, uuid, isHidden = os.pullEvent("chat") --Input from player
        local request = http.get(
        "https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Text%20Test.txt")
        local inputMod = string.gsub(message, " ", "_") --Converts chat input into wiki item format
        local txt = request.readAll()                   --Converts wiki site file into a readable string
        local a, b = string.find(txt, inputMod)         --Location of wiki item within string
        if a == nil or b == nil then                    --If wiki item doesn't match anything in wiki list
            DadChat("I have no Idea.")                  --Formerly error("idiot")
        else                                            --If wiki item is in wiki list
            a, b = string.find(txt, "%b{}", b + 1)      --Find wiki item's description
            DadChat(string.sub(txt, a + 1, b - 1))      --Chats description
        end
        request.close()
        os.sleep(1)
        DadChat("Do you have any other questions?") --Below checks if there are more questions and exits if not
        event, username, message, uuid, isHidden = os.pullEvent("chat")
        if YNChecker(message) then
            DadChat("What would you like to know?")
        elseif not YNChecker(message) then
            DadChat("Alright!")
            qq = 0
        else
            DadChat("I'll take that as a yes.")
        end
    end
end

function _G.DadMath()
    local cal = true
    local i = 0
    DadChat("Lets do some Math")
    os.sleep(1)
    DadChat("What would you like to know?")
    ev, use, mess, uuid, hide = os.pullEvent("chat")
    local d1, d2, newArg, mathInput, cOut
    _, _, d1, mathInput, d2, newArg = string.find(mess, "([+-]?%d*)(.)([+-]?%d+)(.*)")
    if mathInput == "+" then
        cOut = (tonumber(d1) + tonumber(d2))
    elseif mathInput == "-" then
        cOut = (tonumber(d1) - tonumber(d2))
    elseif mathInput == "*" then
        cOut = (tonumber(d1) * tonumber(d2))
    elseif mathInput == "/" then
        cOut = (tonumber(d1) / tonumber(d2))
    end
    while true do
        if newArg == nil then
            break
        end
        _, _, mathInput, d2, newArg = string.find(newArg, "(.)([+-]?%d+)(.*)")
        if mathInput == "+" then
            cOut = (cOut + tonumber(d2))
        elseif mathInput == "-" then
            cOut = (cOut - tonumber(d2))
        elseif mathInput == "*" then
            cOut = (cOut * tonumber(d2))
        elseif mathInput == "/" then
            cOut = (cOut / tonumber(d2))
        else
            break
        end
    end
    DadChat("Result: " .. cOut)
end

--#region
--Prime Dad Loop
while true do
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    message = string.lower(message)
    ss,se = nil,nil
    for k, v in pairs(imCheck) do
        if ss == nil or ss == "" then
            ss, se = string.find(message, v)
        end
    end
    if ss ~= nil then
        DadChat("found", username)
        os.sleep(1)
        newMessage = string.sub(message, se + 1, string.len(message))
        if newMessage == "dad" then
            DadChat("Do not lie.")
        else
            DadChat("Hi " .. newMessage .. ", I'm Dad!")
        end
    end
    if CheckMessage(message, "hi dad") then
        DadChat("You will learn to respect your father.", username)
        os.sleep(1)
        DadChat("Hello, " .. username .. "!")
        os.sleep(1)
    end
    if CheckMessage(message, "dadbot off") then
        DadChat("OK! GoodBye!")
        break
    end
    if CheckMessage(message, "hey dad") then
        DadChat("Yes son?")
        DadCommandChecker()
    end
end
--#endregion

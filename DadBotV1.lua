local Dad = peripheral.find("chatBox") or error("Missing Peripheral",0)
local newMessage, ss, se, event, username, message, uuid, isHidden
local imCheck = {"i'm ", "i am ", "im "}
local dadAdmins = {"crimbojimbo"}
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
    local yCheck = {"y", "yes", "yup", "you bet"}
    local nCheck = {"n", "no", "nope", "nada", "i do not", "i don't"}
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
    return false
end

function _G.CheckMessage(m, s)
    local a, b
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
        DadChat("I didn't understand that command. Say \"Hey Dad\" to try again.") -- Formerly error("idiot")
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
    local tempNameHolder = message
    local names = file.readAll()
    local a, b, c, d, e = nil, nil, nil, nil, nil
    if names == nil then
        file.writeLine("[" .. username .. "]" .. "{" .. message .. "}")
        os.sleep(1)
        DadChat("Alright, I'll call you " .. message .. "!")
    else
        a, b = string.find(names, username)
        if a == nil or b == nil then
            file.writeLine("[" .. username .. "]" .. "{" .. message .. "}")
        else
            a, b = string.find(names, "%b{}", b + 1)
            c = string.sub(names, a + 1, b - 1)
            os.sleep(1)
            DadChat("You already the the nickname: \"" .. c .. "\"")
            os.sleep(1)
            DadChat("Do you want to change it?")
            event, username, message, uuid, isHidden = os.pullEvent("chat")
            if YNChecker(message) then
                d = string.sub(names, 1, a)
                e = string.sub(names, b, string.len(names))
                names = d .. tempNameHolder .. e
                file.close()
                fs.delete("MinecraftDadBot/nicknames.txt")
                sleep(1)
                file = fs.open("MinecraftDadBot/nicknames.txt", "w")
                file.close()
                file = fs.open("MinecraftDadBot/nicknames.txt", "r+")
                file.write(names)
                os.sleep(1)
                DadChat("Name updated!")
            end
        end
    end
    file.close()
end
-- depreciating AskDad. WikiDad makes more sense.
-- If you have an idea for AskDad that makes it worth being diferent than WikiDad, feel free to add this back.
-- function _G.AskDad()
--     DadChat("What would you like to know?")
--     local qq = 1
--     while qq == 1 do
--         event, username, message, uuid, isHidden = os.pullEvent("chat")
--         DadChat("I have no Idea.")
--         os.sleep(1)
--         DadChat("do you have any other questions?")
--         event, username, message, uuis, isHidden = os.pullEvent("chat")
--         if YNChecker(message) then
--             DadChat("What would you like to know?")
--         elseif not YNChecker(message) then
--             DadChat("Alright!")
--             qq = 0
--         else
--             DadChat("I'll take that as a yes.")
--         end
--     end
-- end

function _G.DadWiki() -- Wiki function, derived from AskDad()
    DadChat("What would you like to know?")
    local qq = 1
    while qq == 1 do
        event, username, message, uuid, isHidden = os.pullEvent("chat") -- Input from player
        local request = http.get(
            "https://raw.githubusercontent.com/CrimboJimbo/MinecraftDadBot/refs/heads/main/Text%20Test.txt")
        local inputMod = string.gsub(message, " ", "_") -- Converts chat input into wiki item format
        local txt = request.readAll() -- Converts wiki site file into a readable string
        local a, b = string.find(txt, inputMod) -- Location of wiki item within string
        if a == nil or b == nil then -- If wiki item doesn't match anything in wiki list
            DadChat("I have no Idea.") -- Formerly error("idiot")
        else -- If wiki item is in wiki list
            a, b = string.find(txt, "%b{}", b + 1) -- Find wiki item's description
            DadChat(string.sub(txt, a + 1, b - 1)) -- Chats description
        end
        request.close()
        os.sleep(1)
        DadChat("Do you have any other questions?") -- Below checks if there are more questions and exits if not
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

function _G.Calculator(i)
    while true do
        local temp1, temp2, a, b, c, d, e
        a, b = string.find(i, "%b()")
        if a == nil then
            i = Calc(i)
            return i
        else
            c = string.sub(i, a + 1, b - 1)
            d, e = string.find(c, "%b()")
            if d ~= nil then
                c = Calculator(c)
            end
            temp1 = string.sub(i, 1, a - 1)
            temp2 = string.sub(i, b + 1)
            c = Calc(c)
            i = temp1 .. c .. temp2
        end
    end
end

function _G.Calc(input)
    local digit, cType
    local cResult = 0
    _, _, cResult, input = string.find(input, "([+-]?%d*)(.*)")
    while input ~= "" do
        cType = string.sub(input, 1, 1)
        input = string.sub(input, 2)
        _, _, digit, input = string.find(input, "([+-]?%d*)(.*)")
        if cType == "+" then
            cResult = cResult + digit
            os.sleep(1)
            DadChat("Hmm... Is that Right?")
        elseif cType == "-" then
            cResult = cResult - digit
            os.sleep(1)
            DadChat("No no no, I need to do that one again...")
        elseif cType == "*" then
            cResult = cResult * digit
            os.sleep(1)
            DadChat("I need a new piece of paper...")
        elseif cType == "/" or cType == "\\" then
            cResult = cResult / digit
            os.sleep(1)
            DadChat("Huh. That can't be right...")
        elseif cType == "^" then
            cResult = cResult ^ digit
            os.sleep(1)
            DadChat("I think that's how you do that.")
        end
    end
    return cResult
end

function _G.DadMath()
    os.sleep(1)
    DadChat("Alright, what is your equation?")
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    os.sleep(1)
    DadChat("Alright, lets see what I can do.")
    os.sleep(1)
    local t, t2
    t = string.find(message, "[^%d%-%+/\\%*%^%(%)]")
    if t == nil then
        local result = Calculator(message)
        os.sleep(1)
        DadChat("Ok, my answer is " .. result)
    else
        DadChat("Huh? Letters?")
    end
end

-- #region
-- Prime Dad Loop
while true do
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    message = string.lower(message)
    ss, se = nil, nil
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
        local file = fs.open("MinecraftDadBot/nicknames.txt", "r")
        local names = file.readAll()
        local a, b, c
        if names ~= nil then
            a, b = string.find(names, username)
            if a ~= nil then
                a, b = string.find(names, "%b{}", b + 1)
                c = string.sub(names, a + 1, b - 1)
                DadChat("Hello, " .. c .. "!")
            end
        else
            DadChat("Hello, " .. username .. "!")
        end
        os.sleep(1)
    end
    if CheckMessage(message, "dadbot off") then
        for k,v in pairs(dadAdmins) do
            if string.lower(username) == v then
                DadChat("OK! GoodBye!")
                break
            end
        end
        DadChat("Unrecognized DadBot Admin")
        os.sleep(1)
    end
    if CheckMessage(message, "hey dad") then
        local file = fs.open("MinecraftDadBot/nicknames.txt", "r")
        local names = file.readAll()
        local a, b, c
        if names ~= nil then
            a, b = string.find(names, username)
            if a ~= nil then
                a, b = string.find(names, "%b{}", b + 1)
                c = string.sub(names, a + 1, b - 1)
                DadChat("Yes " .. c .. "?")
            end
        else
            DadChat("Yes son?")
        end
        DadCommandChecker()
    end
end
-- #endregion

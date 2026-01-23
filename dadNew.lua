local Dad = peripheral.find("chat_box") or error("Missing Peripheral",0)
local detector = peripheral.find("player_detector") or nil
local newMessage, ss, se, event, username, message, uuid, isHidden

local dadmin = 'crimbojimbo'

function Dad.chat(mes, player)
    if not mes then
        Dad.sendMessageToPlayer("Chat called with no message", 'crimbojimbo')
    end
    if player then
        Dad.sendMessageToPlayer(mes, player, "DadBot", "<>", "&e")
    else
        Dad.sendMessage(mes, "DadBot", "<>", "&e")
    end
    os.sleep(1)
end

function Dad.wiki()
    ss,se = nil,nil
    local namech = 0
    while true do
        event, username, message, uuid, isHidden = os.pullEvent("chat")
        if Dad.currentuser == username then
            break
        end
        if namech <= 5 then
            Dad.chat("Sorry son, I was talking to your brother! You will have to wait your turn...")
        else
            Dad.chat("Alright, Alright. I'll stop waiting for "..Dad.currentuser)
            return
        end
        namech = namech + 1
    end
    local qCheck = {'creeper','dirt','aether'}
    local sel = 0
    -- Questions Table
    for k, v in pairs(qCheck) do
        if ss == nil or ss == "" then
            ss, se = string.find(string.lower(message), v,1,true)
        end
        if ss ~= nil then
            sel = k
            break
        end
    end
    if sel == 0  then
        Dad.chat("No recognized question, check logs")
        return
    elseif sel == 1 then
        Dad.chat("\"Revenge\" is a Minecraft parody of the song DJ's Got Us Fallin' in Love by Usher featuring Pitbull. It was written, produced and partly-sung by CaptainSparklez, with the main vocals sung by TryHardNinja. The animated music video for the song was uploaded by CaptainSparklez onto YouTube on 19 August 2011. It has over 279 million views and 4.3 million likes as of December 2022. It formerly held the record for the most viewed Minecraft video on YouTube until November 2021, when it was surpassed by \"Animation vs. Minecraft (original)\" by Alan Becker.")
        return
    elseif sel == 2 then
        Dad.chat("You... You don't know what 'Dirt' is?")
        Dad.chat("I've failed you as a father...")
        return
    elseif sel == 3 then
        Dad.chat("Huh? The What?")
        return
    end
    Dad.chat("The variable \'sel\' was not recognized, check logs")
end

local imCheck = {"i'm ", "i am ", "im "}
local wikiCheck = {'dadwiki','wikidad','askdad','question for dad','dad i have a question','dad, i have a question','hey dad'}
local meCheck = {'who am i', 'dadme'}
Dad.chat("Dad has been activated! Welcome to DadBot", dadmin)
Dad.currentuser = ""
while true do
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    Dad.currentuser = username
    for k, v in pairs(imCheck) do
        if ss == nil or ss == "" then
            ss, se = string.find(string.lower(message), v)
        end
    end
    if ss ~= nil then
        newMessage = string.sub(message, se + 1, string.len(message))
        if string.lower(newMessage) == "dad" then
            Dad.chat("That's funny, I thought I was Dad!")
        else
            Dad.chat("Hi " .. newMessage .. ", I'm Dad!")
        end
    end
    ss,se = nil,nil
    for k, v in pairs(wikiCheck) do
        if ss == nil or ss == "" then
            ss, se = string.find(string.lower(message), v)
        end
    end
    if ss ~= nil then
        Dad.chat("What would you like to know?")
        Dad.wiki()
    end
    ss,se = nil,nil
    if detector ~= nil then
        for k, v in pairs(meCheck) do
            if ss == nil or ss == "" then
                ss, se = string.find(string.lower(message), v)
            end
        end
        if ss ~= nil then
            local info = detector.getPlayerPos(Dad.currentuser)
            Dad.chat("You are at: X "..info.x.." | Y "..info.y.." | Z "..info.z)
            Dad.chat("You are in: "..info.dimension)
            Dad.chat("Eyeheight: "..info.eyeHeight.." | Head Pitch: "..info.pitch.." | Head Yaw: "..info.yaw)
            Dad.chat("Health: "..info.health.."/"..info.maxHealth.." | Air Supply: "..info.airSupply)
            Dad.chat("You will respawn at: X "..info.respawnPosition.x.." | Y "..info.respawnPosition.y.." | Z "..info.respawnPosition.z)
            Dad.chat("You will respawn in: "..info.respawnDimension)
        end
        ss,se = nil,nil
    end
    Dad.currentuser = ""
end
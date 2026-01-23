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

local deck = {
    "Ace of Hearts","2 of Hearts","3 of Hearts","4 of Hearts","5 of Hearts","6 of Hearts","7 of Hearts","8 of Hearts","9 of Hearts","10 of Hearts","Jack of Hearts","Queen of Hearts","King of Hearts",
    "Ace of Spades","2 of Spades","3 of Spades","4 of Spades","5 of Spades","6 of Spades","7 of Spades","8 of Spades","9 of Spades","10 of Spades","Jack of Spades","Queen of Spades","King of Spades",
    "Ace of Diamonds","2 of Diamonds","3 of Diamonds","4 of Diamonds","5 of Diamonds","6 of Diamonds","7 of Diamonds","8 of Diamonds","9 of Diamonds","10 of Diamonds","Jack of Diamonds","Queen of Diamonds","King of Diamonds",
    "Ace of Clubs","2 of Clubs","3 of Clubs","4 of Clubs","5 of Clubs","6 of Clubs","7 of Clubs","8 of Clubs","9 of Clubs","10 of Clubs","Jack of Clubs","Queen of Clubs","King of Clubs"
}

function Dad.blackJack()
    local tDeck = deck
    local sDeck = {}
    local r = 0
    while #tDeck > 0 do
        r = math.random(#tDeck)
        table.insert(sDeck, table.remove(tDeck,r))
    end
    local dadHand = {}
    local playerHand = {}
    local gameOver = false
    r = math.random(#sDeck)
    table.insert(dadHand, table.remove(sDeck,r))
    table.insert(playerHand, table.remove(sDeck,r))
    table.insert(dadHand, table.remove(sDeck,r))
    table.insert(playerHand, table.remove(sDeck,r))
    Dad.chat("Alright, I've got "..dadHand[1]..".")
    Dad.chat("You have "..playerHand[1].." and "..playerHand[2]..".")
    Dad.chat("Hit or Show?")
    local function score()
        local pscore, dscore, firstc = 0,0,""
        for k, v in pairs(dadHand) do
            firstc = string.sub(v,1,1)
            if tonumber(firstc) then
                dscore = dscore + tonumber(firstc)
            elseif firstc == "A" then
                if dscore <= 10 then
                    dscore = dscore + 11
                else
                    dscore = dscore + 1
                end
            end
        end
        for k, v in pairs(playerHand) do
            firstc = string.sub(v,1,1)
            if tonumber(firstc) then
                pscore = pscore + tonumber(firstc)
            elseif firstc == "A" then
                if pscore <= 10 then
                    pscore = pscore + 11
                else
                    pscore = pscore + 1
                end
            end
        end
        return pscore, dscore
    end
    local playCheck = {"hit","hitme","hit me","give me another card","card","another"}
    local foldCheck = {"fold","stand","show","done","reveal","call"}
    local playerScore,dadScore = 0,0
    while not gameOver do
        ss,se = nil,nil
        for k, v in pairs(playCheck) do
            if ss == nil or ss == "" then
                ss, se = string.find(string.lower(message), v)
            end
        end
        if ss ~= nil then
            r = math.random(#sDeck)
            Dad.chat("You drew "..sDeck[r]..".")
            table.insert(playerHand, table.remove(sDeck,r))
            playerScore, dadScore = score()
        end
        if playerScore > 21 then
            Dad.chat("Thats a bust with "..playerScore..". Looks like I've still got it!")
            gameOver = true
        end
        ss,se = nil,nil
        for k, v in pairs(foldCheck) do
            if ss == nil or ss == "" then
                ss, se = string.find(string.lower(message), v)
            end
        end
        if ss ~= nil then
            Dad.chat("My second card was "..dadHand[2]..".")
            playerScore, dadScore = score()
            while dadScore < 21 and dadScore < playerScore  and not gameOver do
                if dadScore <= 21 and dadScore > playerScore then
                    Dad.chat("Looks like I won with "..dadScore.."!")
                    gameOver = true
                else
                    r = math.random(#sDeck)
                    Dad.chat("I drew "..sDeck[r])
                    table.insert(dadHand, table.remove(sDeck,r))
                    playerScore, dadScore = score()
                end
            end
            if dadScore > 21 then
                Dad.chat("Looks like I busted with "..dadScore..". Good job champ!")
                return
            end
        end
        Dad.chat("Hit or Show?")
    end
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
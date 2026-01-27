local Dad = peripheral.find("chat_box") or error("Missing Peripheral",0)
local detector = peripheral.find("player_detector") or nil
local newMessage, ss, se, event, username, message, uuid, isHidden

local dadmin = 'crimbojimbo'

function Dad.chat(mes, player)
    local formattedMessage = {
        {
            text = mes,
            color = "green"
        }
    }
    local json = textutils.serialiseJSON(formattedMessage)
    if not mes then
        Dad.sendMessageToPlayer("&4&bChat called with no message", dadmin)
    end
    if player then
        Dad.sendMessageToPlayer(mes, player, "DadBot", "<>", "&e")
    else
        Dad.sendFormattedMessage(json, "DadBot", "<>", "&e")
    end
    os.sleep(1)
end
function Dad.jsonChat(jsonMes, player)
    if not jsonMes then
        Dad.sendMessageToPlayer("&4&bChat called with no message", dadmin)
    end
    if player then
        Dad.sendFormattedMessageToPlayer(jsonMes, player, "DadBot", "<>", "&e")
    else
        Dad.sendFormattedMessage(jsonMes, "DadBot", "<>", "&e")
    end
    os.sleep(1)
end
function Dad.toast(mes, player, title)
    title = title or "Dad"
    if not mes then
        Dad.sendMessageToPlayer("&4&bToast called with no message", dadmin)
    else
        Dad.sendToastToPlayer(mes, title, player, "DadBot", "<>", "&e")
    end
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
    local tDeck = {}
    local function getSuit(str)
        local suitC = ""
        if string.find(str,"Clubs") or string.find(str, "Spades") then
            suitC = "#1C1C1F"
        else
            suitC = "#EE423C"
        end
        return suitC
    end
    for k,v in pairs(deck) do
        tDeck[k] = deck[k]
    end
    local sDeck = {}
    local r = 0
    while #tDeck > 0 do
        r = math.random(#tDeck)
        table.insert(sDeck, table.remove(tDeck,r))
    end
    local dadHand = {}
    local playerHand = {}
    r = math.random(#sDeck)
    table.insert(dadHand, table.remove(sDeck,r))
    r = math.random(#sDeck)
    table.insert(playerHand, table.remove(sDeck,r))
    r = math.random(#sDeck)
    table.insert(dadHand, table.remove(sDeck,r))
    r = math.random(#sDeck)
    table.insert(playerHand, table.remove(sDeck,r))
    -- Dad.chat("Alright, I've got "..dadHand[1]..".")
    local j = {
        {
            text = "Alright, I've got ",
            color = "green"
        },
        {
            text = dadHand[1],
            color = getSuit(dadHand[1])
        }
    }
    local json = textutils.serialiseJSON(j)
    Dad.jsonChat(json)
    -- Dad.chat("You have "..playerHand[1].." and "..playerHand[2]..".")
    j = {
        {
            text = "You have ",
            color = "green"
        },
        {
            text = playerHand[1],
            color = getSuit(playerHand[1])
        },
        {
            text = " and ",
            color = "green"
        },
        {
            text = playerHand[2],
            color = getSuit(playerHand[2])
        }
    }
    json = textutils.serialiseJSON(j)
    Dad.jsonChat(json)
    local function score()
        local pscore, dscore, firstc = 0,0,""
        for k, v in pairs(dadHand) do
            firstc = string.sub(v,1,1)
            if tonumber(firstc) then
                if string.sub(v,2,2) == "0" then
                    dscore = dscore + 10
                else
                    dscore = dscore + tonumber(firstc)
                end
            elseif firstc == "A" then
                if dscore <= 10 then
                    dscore = dscore + 11
                else
                    dscore = dscore + 1
                end
            else
                dscore = dscore + 10
            end
        end
        for k, v in pairs(playerHand) do
            firstc = string.sub(v,1,1)
            if tonumber(firstc) then
                if string.sub(v,2,2) == "0" then
                    pscore = pscore + 10
                else
                    pscore = pscore + tonumber(firstc)
                end
            elseif firstc == "A" then
                if pscore <= 10 then
                    pscore = pscore + 11
                else
                    pscore = pscore + 1
                end
            else
                pscore = pscore + 10
            end
        end
        print('p:'..pscore..' | d:'..dscore)
        return pscore, dscore
    end
    local playCheck = {"hit","hitme","hit me","give me another card","card","another"}
    local foldCheck = {"fold","stand","show","done","reveal","call"}
    local playerScore,dadScore = 0,0
    while true do
        playerScore, dadScore = score()
        Dad.chat("Hit or Show?")
        event, username, message, uuid, isHidden = os.pullEvent("chat")
        ss,se = nil,nil
        for k, v in pairs(playCheck) do
            if ss == nil or ss == "" then
                ss, se = string.find(string.lower(message), v)
            end
        end
        if ss ~= nil then
            r = math.random(#sDeck)
            j = {
                {
                    text = "You Drew ",
                    color = "green"
                },
                {
                    text = sDeck[r],
                    color = getSuit(sDeck[r])
                }
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            -- Dad.chat("You drew "..sDeck[r]..".")
            table.insert(playerHand, table.remove(sDeck,r))
            playerScore, dadScore = score()
        end
        playerScore, dadScore = score()
        if playerScore > 21 then
            Dad.chat("Thats a bust with "..playerScore..". Looks like I've still got it!")
            return
        end
        ss,se = nil,nil
        for k, v in pairs(foldCheck) do
            if ss == nil or ss == "" then
                ss, se = string.find(string.lower(message), v)
            end
        end
        if ss ~= nil then
            -- Dad.chat("My second card was "..dadHand[2]..".")
            j = {
                {
                    text = "My second card was ",
                    color = "green"
                },
                {
                    text = dadHand[2],
                    color = getSuit(dadHand[2])
                }
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            playerScore, dadScore = score()
            while dadScore <= 21 do
                if dadScore < 22 and dadScore > playerScore then
                    Dad.chat("Looks like I won with "..dadScore.."!")
                    return
                else
                    r = math.random(#sDeck)
                    -- Dad.chat("I drew "..sDeck[r])
                    j = {
                        {
                            text = "I drew ",
                            color = "green"
                        },
                        {
                            text = sDeck[r],
                            color = getSuit(sDeck[r])
                        }
                    }
                    table.insert(dadHand, table.remove(sDeck,r))
                    playerScore, dadScore = score()
                end
                if dadScore > 21 then
                    Dad.chat("Looks like I busted with "..dadScore..". Good job champ!")
                    return
                end
            end
        end
    end
end

local imCheck = {"i'm ", "i am ", "im "}
local wikiCheck = {'dadwiki','wikidad','askdad','question for dad','dad i have a question','dad, i have a question','hey dad'}
local meCheck = {'who am i', 'dadme', 'i hate dad', 'dad is stupid', 'you can\'t find me', 'dadthot', 'shut up dad', 'fuck off dad', 'kys', 'xd'}
local bjCheck = {"blackjack",'dadgame1'}
local toastCheck = {'toast'}
Dad.chat("Dad has been activated! Welcome to DadBot", dadmin)
Dad.currentuser = ""
local function checkInput(mes, arr)
    for k, v in pairs(arr) do
        if ss == nil or ss == "" then
            ss, se = string.find(string.lower(mes), v)
        end
    end
    if ss ~= nil then
        return true, ss, se
    end
    ss,se = nil,nil
    return false, ss, se
end
while true do
    local mesTF = false
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    Dad.currentuser = username
    mesTF,ss,se=false,nil,nil
    mesTF,ss,se = checkInput(message, imCheck)
    if mesTF then
        newMessage = string.sub(message, se + 1, string.len(message))
        if string.lower(newMessage) == "dad" then
            Dad.chat("That's funny, I thought I was Dad!")
        else
            Dad.chat("Hi " .. newMessage .. ", I'm Dad!")
        end
    end
    mesTF,ss,se=false,nil,nil
    mesTF,ss,se = checkInput(message, wikiCheck)
    if mesTF then
        Dad.chat("What would you like to know?")
        Dad.wiki()
    end
    if detector ~= nil then
        mesTF,ss,se=false,nil,nil
        mesTF,ss,se = checkInput(message, meCheck)
        if mesTF then
            local info = detector.getPlayerPos(Dad.currentuser)
            local j = {
                {
                    text = "You are at: ",
                    color = "#FFFFFF"
                },
                {
                    text = "X "..info.x.." ",
                    color = "#1BB36E"
                },
                {
                    text = "Y "..info.y.." ",
                    color = "#A4B31B"
                },
                {
                    text = "Z "..info.z..".",
                    color = "#B3251B"
                },
            }
            local json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            j = {
                {
                    text = "Your respawn is at: ",
                    color = "#FFFFFF"
                },
                {
                    text = "X "..info.respawnPosition.x.." ",
                    color = "#1BB36E"
                },
                {
                    text = "Y "..info.respawnPosition.y.." ",
                    color = "#A4B31B"
                },
                {
                    text = "Z "..info.respawnPosition.z..".",
                    color = "#B3251B"
                },
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            j = {
                {
                    text = "You are in dimension: ",
                    color = "#FFFFFF"
                },
                {
                    text = info.dimension..". ",
                    color = "#1BB36E"
                },
                {
                    text = "And will respawn in: ",
                    color = "#FFFFFF"
                },
                {
                    text = info.respawnDimension..".",
                    color = "#1BB36E"
                },
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            j = {
                {
                    text = "Eyeheight: ",
                    color = "#FFFFFF"
                },
                {
                    text = info.eyeHeight.." ",
                    color = "#1BB36E"
                },
                {
                    text = "Head: ",
                    color = "#FFFFFF"
                },
                {
                    text = "Pitch: "..info.pitch.." ",
                    color = "#A4B31B"
                },
                {
                    text = "Yaw: "..info.yaw..". ",
                    color = "#B3251B"
                },
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
            j = {
                {
                    text = "Life info: ",
                    color = "#FFFFFF"
                },
                {
                    text = "Current Health: "..info.health.." ",
                    color = "#1BB36E"
                },
                {
                    text = "Max Health: "..info.maxHealth.." ",
                    color = "#A4B31B"
                },
                {
                    text = "Air Supply: "..info.airSupply..". ",
                    color = "#B3251B"
                },
            }
            json = textutils.serialiseJSON(j)
            Dad.jsonChat(json)
        end
    end
    mesTF,ss,se=false,nil,nil
    mesTF,ss,se = checkInput(message, bjCheck)
    if mesTF then
        Dad.chat("Lets play Black Jack!")
        Dad.blackJack()
    end
    mesTF,ss,se=false,nil,nil
    mesTF,ss,se = checkInput(message, toastCheck)
    if mesTF then
        local p = string.match(message, "%[(.-)%]")
        local m = string.match(message, "%{(.-)%}")
        Dad.toast(m,p,"test")
    end
    Dad.currentuser = ""
end
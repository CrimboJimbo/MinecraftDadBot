local Dad = peripheral.wrap("right")
local newMessage,ss,se,event,username,message,uuid,isHidden = ""
local imCheck = {"i'm ","i am ","im "}
local qCheck = {"hey dad","i have a question","question for dad","??dad??"}
Dad.sendMessage("Hello son!","DadBot","<>","&e")

function DadChat(m,t)
local Dad = peripheral.wrap("right")
    if t == nil then
        Dad.sendMessage(m,"DadBot","<>","&e")
    else
        Dad.sendMessageToPlayer(m,t,"Entity","[]","&4")
    end
end
function CheckMessage(m,s)
    m = string.lower(m)
    ss,se = string.find(m,s)
    if ss == nil then
        return false
    else
        return true
    end
end
function AskDad()
    DadChat("What would you like to know?")
    local qq = 1
    local yCheck = {"y","yes","yup","you bet"}
    local nCheck = {"n","no","nope","nada","i do not","i don't"}
    while qq == 1 do
        event, username,message,uuid, isHidden = os.pullEvent("chat")
        DadChat("I have no Idea.")
        os.sleep(1)
        DadChat("do you have any other questions?")
        event, username,message,uuis,isHidden = os.pullEvent("chat")
        for k,v in pairs(yCheck) do
            if CheckMessage(message,v) then
                DadChat("What would you like to know?")
            end
        end
        for k,v in pairs(nCheck) do
            if CheckMessage(message,v) then
                DadChat("Alright!")
                qq=0
            end
        end
        DadChat("I'll take that as a yes.")
    end
end
function DadMath()
    local cal = true
    local i = 0
    DadChat("Lets do some Math")
    os.sleep(1)
    DadChat("What would you like to know?")
    ev,use,mess,uuid,hide=os.pullEvent("chat")
    while cal == true do
        while true do
            i = string.find(mess,"[%+%-%\\%*]",i+1)
            if i == nil then break end
            if string.sub(mess,i) == "+" then
                break
            end
        end
    end
end

while true do
    event, username, message, uuid, isHidden = os.pullEvent("chat")
    message = string.lower(message)
    for k,v in pairs(imCheck) do
        if ss == nil or ss == "" then
            ss,se = string.find(message,v)
        end
    end
    if ss ~= nil then
        DadChat("found",username)
        os.sleep(1)
        newMessage = string.sub(message,se+1,string.len(message))
        if newMessage == "dad" then
            DadChat("Do not lie.")
        else
            DadChat("Hi "..newMessage..", I'm Dad!")
        end
    end
    if CheckMessage(message,"hi dad") then
        DadChat("You will learn to respect your father.",username)
        os.sleep(1)
        DadChat("Hello, "..username.."!")
        os.sleep(1)        
    end
    if CheckMessage(message,"dadbot off") then
        DadChat("OK! GoodBye!")
        break
    end
    for k,v in pairs(qCheck) do
        if CheckMessage(message,v) then
            AskDad()
        end
    end
end

local beginTime = GetTimeSinceStart()
local lastSeenTime = beginTime
local flickerState = false
local FlickerLog = nil
local FlickerPrint = nil
if SN3Debug then
    local flickerRecord = {}
    FlickerLog = function()
        table.insert(flickerRecord, true)
    end
    local oldDiff = 0
    FlickerPrint = function()
        local diff = math.floor(lastSeenTime-beginTime)
        if (diff % 15 == 0) and (diff ~= oldDiff) then
            oldDiff = diff
            SCREENMAN:SystemMessage("flicker debug: flickered avg "..tostring((#flickerRecord)/15).."Hz over last 15 sec")
            flickerRecord = {}
        end
    end
end

local targetDelta = 1/60
local function CalculateFlickerWaitFrames(delta)
    return math.max(1, math.round(targetDelta/delta))-1
end

local fCounter = 0
local function FlickerUpdate(self, _)
    lastSeenTime = GetTimeSinceStart()
    if FlickerPrint then FlickerPrint() end
    if fCounter >0 then fCounter = fCounter-1 return end

    if FlickerLog then FlickerLog() end 
    flickerState = not flickerState
    
    for pn, item in pairs(self:GetChildren()) do
        item:visible((GAMESTATE:GetPlayerState(pn):GetHealthState() == 'HealthState_Hot')
            and flickerState)
    end
   
    fCounter = CalculateFlickerWaitFrames(1/DISPLAY:GetCumFPS())
end

local host = Def.ActorFrame{
    Name = "HotLifeFlicker",
    InitCommand = function(self) self:SetUpdateFunction(FlickerUpdate) end;
}

local xPosPlayer = {
    P1 = -(SCREEN_WIDTH/6), 
    P2 = (SCREEN_WIDTH/6)
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    table.insert(host,Def.Quad{
        Name = pn,
        InitCommand=function(self)
            local short = ToEnumShortString(pn)
            self:visible(false):setsize((SCREEN_WIDTH/2.53),13)
            :skewx(-0.9):diffuse(color "0.75,0.75,0.75,0.8"):x(xPosPlayer[short])
            :halign(0.75)
        end,
        OnCommand=function(s) s:draworder(3):zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
        OffCommand=function(s) s:sleep(0.792):addy(999) end
    })
end
return host
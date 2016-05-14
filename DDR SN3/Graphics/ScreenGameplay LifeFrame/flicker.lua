local beginTime = GetTimeSinceStart()
local lastSeenTime = beginTime
local minTransitionTime = 0.016
local flickerState = false

local function FlickerUpdate(self, _)
    local curTime = GetTimeSinceStart()
    
    if (curTime - lastSeenTime) >= minTransitionTime then 
        flickerState = not flickerState
    end
    
    for pn, item in pairs(self:GetChildren()) do
        item:visible((GAMESTATE:GetPlayerState(pn):GetHealthState() == 'HealthState_Hot')
            and flickerState)
    end
    
    lastSeenTime = curTime
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
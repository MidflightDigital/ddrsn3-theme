local function GetMetricNumber(name)
    return tonumber(THEME:GetMetric("ScreenGameplay",name))
end
local flickerState = false
local function HotLifeUpdate(self, _)
    flickerState = not flickerState
    for pn, item in pairs(self:GetChildren()) do
        item:visible((GAMESTATE:GetPlayerState(pn):GetHealthState() == 'HealthState_Hot')
            and flickerState)
    end
end
local host = Def.ActorFrame{
    Name = "HotLifeFlicker",
    InitCommand = function(self) self:SetUpdateFunction(HotLifeUpdate) end;
}

local xPosPlayer = {
    P1 = -157, 
    P2 = 157
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    table.insert(host,Def.Quad{
        Name = pn,
        InitCommand=function(self)
            local short = ToEnumShortString(pn)
            self:visible(false):setsize((SCREEN_WIDTH/2.53),13)
            :skewx(-0.9):diffuse(color "#FFFFFF"):x(xPosPlayer[short])
            :halign(0.75)
        end,
        OnCommand=function(s) s:draworder(3):zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
        OffCommand=function(s) s:sleep(0.792):addy(999) end
    })
end
return host
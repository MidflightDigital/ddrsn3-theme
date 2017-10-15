local stageStats = STATSMAN:GetCurStageStats()
local tnsToColor = {
    TapNoteScore_W3=color "#02EC20",
    TapNoteScore_W2=color "#FDF908",
    TapNoteScore_W1=color "#FFF2D9"
}

local playerXPositions = {
    PlayerNumber_P1=SCREEN_CENTER_X-165,
    PlayerNumber_P2=SCREEN_CENTER_X+335
}

local actors = Def.ActorFrame{}

for _, player in pairs(GAMESTATE:GetEnabledPlayers()) do
    local pss = stageStats:GetPlayerStageStats(player)
    assert(pss, "No PlayerStageStats for "..player..". This might actually be a mistake on your part, Jack.")
    --this whole block is setting up for us to iterate from TNS_W1 down to TNS_Miss
    local revTns = TapNoteScore:Reverse()
    local bestTns = revTns.TapNoteScore_W1
    local worstTns = revTns.TapNoteScore_Miss
    for idx=bestTns, worstTns, -1 do
        local curTns = TapNoteScore[idx]
        if tnsToColor[curTns] then
            if pss:FullComboOfScore(curTns) then
                table.insert(actors,Def.ActorFrame{
                    LoadActor("ring")..{
                        InitCommand=function(self) self:diffuse(tnsToColor[curTns]):x(playerXPositions[player]):y(SCREEN_CENTER_Y-100):zoom(0) end;
                        OnCommand=function(self) self:linear(0.2):zoom(0.65):spin():effectmagnitude(0,0,-170) end;
                        OffCommand=function(self) self:linear(0.2):zoom(0) end
                    },
                    LoadActor("lines")..{
                        InitCommand=function(self) self:diffuse(tnsToColor[curTns]):x(playerXPositions[player]):y(SCREEN_CENTER_Y-100):zoom(0) end;
                        OnCommand=function(self) self:linear(0.2):zoom(1):spin():effectmagnitude(0,0,-170) end;
                        OffCommand=function(self) self:linear(0.2):zoom(0) end
                    }
                })
                break
            end
        else break end
    end
end

return actors
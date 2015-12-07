-- gameplay life frame
local lifeFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "extra" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "extra" end

return Def.ActorFrame{ 
	LoadActor(lifeFrame)..{
		BeginCommand=cmd(queuecommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:cropleft(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropright(0.5)
			end
		end;
	};
};
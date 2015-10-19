-- gameplay life frame
local lifeFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "rave" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "extra" end

return Def.ActorFrame{ 
	LoadActor(lifeFrame)..{
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:IsPlayerEnabled(0) == false then
				self:cropleft(0.5)
			end
		end;
	};
	LoadActor(lifeFrame)..{
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:IsPlayerEnabled(1) == false then
				self:cropright(0.5)
			end
		end;
	};
};
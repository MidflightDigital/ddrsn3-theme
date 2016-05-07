local Player = ...
if not Player then error("ScreenSelectMusic DifficultyIcon requires a Player") end

return Def.ActorFrame{
	LoadActor("_difficulty icons")..{
		InitCommand=cmd(pause);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				-- change icon index based on difficulty
				local steps = GAMESTATE:GetCurrentSteps(Player)
				if steps then
					self:setstate(GetDifficultyIconFrame(steps:GetDifficulty()))
					self:visible(true)
				end
			else
				self:visible(false)
			end
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if Player == PLAYER_1 then self:playcommand("Set") end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if Player == PLAYER_2 then self:playcommand("Set") end
		end;
	};
	LoadActor("_autogen")..{
		InitCommand=cmd(visible,false);
		BeginCommand=cmd(playcommand,"Set");
		ShowCommand=cmd(visible,true;diffuseshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,1"));
		HideCommand=cmd(visible,false;stopeffect);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if Player == PLAYER_1 then self:playcommand("Set") end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if Player == PLAYER_1 then self:playcommand("Set") end
		end;
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local steps = GAMESTATE:GetCurrentSteps(Player)
				if steps then
					if steps:IsAutogen() then self:playcommand("Show")
					else self:playcommand("Hide")
					end
				else
					self:playcommand("Hide")
				end
			else
				self:playcommand("Hide")
			end
		end;
	};
}
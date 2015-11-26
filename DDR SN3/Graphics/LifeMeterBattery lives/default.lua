-- xxx: needs editing for flashing
local player = Var "Player"
local curLives = nil
local lastLives = nil

local t = Def.ActorFrame {
	LoadActor("_lives")..{
		InitCommand=cmd(pause);
		BeginCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			if screen then
				local meter = screen:GetLifeMeter(player)
				curLives = meter:GetTotalLives()
				self:setstate(math.min(curLives-1,3))
				lastLives = curLives
			end
		end;
		LifeChangedMessageCommand=function(self,param)
			if param.Player == player then
				if param.LivesLeft == 0 then
					self:visible(false)
				else
					curLives = param.LivesLeft
					self:setstate( math.max(param.LivesLeft-1,0) )
					self:visible(true)
				end
			end
		end;
	};
};

return t;
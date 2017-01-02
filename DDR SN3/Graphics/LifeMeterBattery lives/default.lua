-- xxx: needs editing for flashing
local player = Var "Player"
local curLives = nil
local lastLives = nil
local stream = "hot"

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame{
-- Battery full line
	LoadActor(THEME:GetPathG("","StreamDisplay " .. stream ))..{
		InitCommand=function(self)
			self:texcoordvelocity(0.8,0)
			self:setsize((SCREEN_WIDTH/2.53),13)
			self:skewx(-0.9)
		end;
		LifeChangedMessageCommand=function(self,params)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			if params.LostLife and params.Player == player then
				self:Load(THEME:GetPathG("StreamDisplay","normal"))
				self:setsize((SCREEN_WIDTH/2.53),13)
			elseif params.LivesLeft <= 3 and params.Player == player then
				stream = "normal"
				self:Load(THEME:GetPathG("StreamDisplay","normal"))
				self:setsize((SCREEN_WIDTH/2.53),13)
			end
		end;
	};
	-- 4 Battery empty red
	Def.Quad{
		InitCommand=function(self)
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
			self:halign(1);
			self:skewx(-0.9);
			self:x(SCREEN_WIDTH/5);
		end;
		BeginCommand=function(self,params)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			self:setsize((SCREEN_WIDTH/10.12)*(4-math.min(4,glifemeter:GetTotalLives())), 13);
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player ~= player then return end;
			if not params.LostLife then return end;
			self:finishtweening();
			self:linear(0);
			self:diffusetopedge(color("#5d1115"));
			self:diffusebottomedge(color("#f50d0d"));
			self:setsize((SCREEN_WIDTH/10.12)*(4-math.min(4,params.LivesLeft)), 13);
			self:linear(0.33);
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
		end;
	};
};
return t;

-- xxx: needs editing for flashing
local player = Var "Player"
local curLives = nil
local lastLives = nil

local t = Def.ActorFrame {
--[[	LoadActor("_lives")..{
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
--]]
	-- Battery 2-7 line
	LoadActor("normal")..{
		InitCommand=function(self)
			self:texcoordvelocity(0.8,0)
			self:setsize((SCREEN_WIDTH/2.53),13)
			self:skewx(-0.9)
			self:visible(false)
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player == player then
				if params.LivesLeft >= 2 then
					self:visible(true)
				else
					self:visible(false)
				end
			end
		end;
	};
	-- Battery full line
	LoadActor("Full")..{
		InitCommand=function(self)
			self:texcoordvelocity(0.8,0)
			self:setsize((SCREEN_WIDTH/2.53),13)
			self:skewx(-0.9)
		end;
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			if glifemeter:GetTotalLives() == 1 then
				self:visible(false)
			else
				self:visible(true)
			end
		end;
		LifeChangedMessageCommand=function(self,params)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			if params.Player == player then
				if glifemeter:GetTotalLives() == 1 then
					self:visible(false)
				elseif params.LivesLeft == glifemeter:GetTotalLives() then
					self:visible(true)
				else
					self:visible(false)
				end
			end
		end;
	};
	-- 4 Battery empty red
	Def.Quad{
		InitCommand=function(self)
			self:diffusetopedge(color("#5d1115"));
			self:diffusebottomedge(color("#f50d0d"));
			self:halign(1);
			self:x(SCREEN_WIDTH/5);
		end;
		BeginCommand=function(self,params)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			if glifemeter:GetTotalLives() <= 5 then
				self:visible(true)
			else
				self:visible(false)
			end
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player ~= player then return end;
			self:finishtweening();
			self:linear(0);
			self:diffusetopedge(color("#5d1115"));
			self:diffusebottomedge(color("#f50d0d"));
			self:zoomto((SCREEN_WIDTH/2.53)-((params.LivesLeft-1)*113.5),13);
			self:linear(0.33);
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
		end;	
	};
--[[	-- 4 Battery empty over
	Def.Quad{
		InitCommand=function(self)
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
			self:setsize((SCREEN_WIDTH/2.53),13);
			self:skewx(-0.9);
		end;
		BeginCommand=function(self,params)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			if glifemeter:GetTotalLives() <= 5 then
				self:visible(true)
				if glifemeter:GetTotalLives() == 4 or glifemeter:GetTotalLives() == 5 then
					self:zoomto(0,13);
				elseif glifemeter:GetTotalLives() == 3 then
					self:zoomto((SCREEN_WIDTH/7.5),13);
				elseif glifemeter:GetTotalLives() == 2 then
					self:zoomto((SCREEN_WIDTH/3.76),13);
				elseif glifemeter:GetTotalLives() == 1 then
					self:zoomto((SCREEN_WIDTH/2.5),13);
				end
			else
				self:visible(false)
			end
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player ~= player then return end;
			self:finishtweening();
			self:sleep(0.33);
			self:skewx(-0.9);
		end;
	};

	Def.Sprite {
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			
			if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
				if glifemeter:GetTotalLives() > 5 then
					self:Load(THEME:GetPathG("LifeMeterBattery","lives/_8frame_2013"));
				else
					self:Load(THEME:GetPathG("LifeMeterBattery","lives/wide split"));
				end
			elseif glifemeter:GetTotalLives() > 5 then
				self:Load(THEME:GetPathG("LifeMeterBattery","lives/_8frame_2013"));
			else
				--[[
				if style == "StyleType_TwoPlayersTwoSides" then
					self:Load(THEME:GetPathG("LifeMeterBattery","lives/4frame"));
				else
					local bComboGraphic = ComboGraphic(player);
					if bComboGraphic == '2013' then
						self:Load(THEME:GetPathG("LifeMeterBattery","lives/_4frame_2013"));
						self:zoomx(WideScale(1,0.696));
						self:y(20);
					else
						self:Load(THEME:GetPathG("LifeMeterBattery","lives/4frame"));
						self:y(0);
					end
				end;
				--]]
				self:y(0);
				self:Load(THEME:GetPathG("LifeMeterBattery","lives/wide split"));
			end
		end;
	};
--]]
};
return t;
-- gameplay life frame

-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " standard",
	[math.floor(10000*16/9)] = " widescreen",
	[math.floor(10000*16/10)] = " widescreen"
}
--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

local lifeFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "special"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "special" end
if GAMESTATE:IsAnExtraStage() then lifeFrame = "special" end

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(lifeFrame..suffix,1,true) then
	lifeFrame = lifeFrame .. suffix
	line = "lines" .. suffix
else
	Warn("ScreenGameplay LifeFrame: missing frame \""..lifeFrame..suffix.."\". Using fallback assets.")
	lifeFrame = lifeFrame.." standard"
	line = "lines standard"
end

local t = Def.ActorFrame{}
t[#t+1] = LoadActor("flicker")
t[#t+1] = LoadActor(lifeFrame)..{
		BeginCommand=function(self,param)
			if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				self:cropleft(0.5)
			elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				self:cropright(0.5)
			end
		end;
};

t[#t+1] = LoadActor(line)..{
	InitCommand=function(self,param)
		if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
			self:cropleft(0.5)
		elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
			self:cropright(0.5)
		end;
	end;
	BeginCommand=function(self,param)
		if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P1','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(false);
		elseif GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P2','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(false);
		else
			self:visible(true);
		end;
	end;
	OnCommand=cmd(diffusealpha,0.4);
};

--Player 1 Risky Splitter
t[#t+1] = LoadActor("splitter")..{
	InitCommand=cmd(x,-(SCREEN_WIDTH/5.5);skewx,-0.9;zoomto,(SCREEN_WIDTH/2.53),14;halign,0.75);
	BeginCommand=function(self,param)
		if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P1','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};

--Player 2 Risky Splitter
t[#t+1] = LoadActor("splitter")..{
	InitCommand=cmd(x,(SCREEN_WIDTH/5.5);skewx,0.9;zoomto,(SCREEN_WIDTH/2.53),14;halign,0.25);
	BeginCommand=function(self,param)
		if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P2','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};

--Player 1 Danger
t[#t+1] = LoadActor("danger 2x1")..{
		InitCommand=cmd(x,WideScale(-160,-213.5);visible,false);
		HealthStateChangedMessageCommand=function(self, param)
			if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				if param.HealthState == "HealthState_Danger" then
					self:visible(true);
				else
					self:visible(false);
				end;
			end;
		end;
};
--Player 2 Danger
t[#t+1] = LoadActor("danger 2x1")..{
		InitCommand=cmd(x,WideScale(160,213.5);visible,false);
		HealthStateChangedMessageCommand=function(self, param)
			if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				if param.HealthState == "HealthState_Danger" then
					self:visible(true);
				else
					self:visible(false);
				end;
			end;
		end;
};
	

return t

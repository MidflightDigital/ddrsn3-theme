local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y);
		self:sleep(0.198);
	end;
	
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor("../Door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-135;zoom,1.01);
		};
	};
	Def.ActorFrame{
		LoadActor("../Door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+134;zoom,1.01);
		};
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y-124);
	end;
	LoadActor("banner_stage")..{
		InitCommand=cmd(CenterX);
		OnCommand=cmd(linear,0.099;zoomy,0);
	};
};

if not GAMESTATE:IsCourseMode() then
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';CenterX;y,SCREEN_CENTER_Y-130;linear,0.099;zoomy,0);
	Def.Sprite {
		SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song:HasBanner() then
				self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
				self:setsize(256,80);
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,80);
			end;
		end;
	};
};
else
t[#t+1] = LoadActor("../ScreenStageInformation in/CourseDisplay");
end;

t[#t+1] = Def.Sprite {
	Texture="rayo 1x2.png",
		InitCommand=function(self)
			self:Center()
			self:SetAllStateDelays(0.082)
		end
};

t[#t+1] = LoadActor("../ScreenStageInformation in/StageDisplay");

t[#t+1] = LoadActor("bottom_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-27);
	OnCommand=cmd(linear,0.198;addy,54);
};

t[#t+1] = LoadActor("top_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_TOP+52);
	OnCommand=cmd(linear,0.198;addy,-104);
};

return t
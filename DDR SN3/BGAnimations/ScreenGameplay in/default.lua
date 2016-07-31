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

t[#t+1] =Def.ActorFrame{
	LoadActor(THEME:GetPathB("","doors open"));
};

if not GAMESTATE:IsCourseMode() then
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';CenterX;y,SCREEN_CENTER_Y-130;accelerate,0.099;zoomy,0);
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

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y-124);
	end;
	LoadActor(THEME:GetPathG("","ScreenEvaluation bannerframe (doubleres)"))..{
		InitCommand=cmd(CenterX);
		OnCommand=cmd(accelerate,0.099;zoomy,0);
	};
};

t[#t+1] = Def.Sprite {
	Texture="../ScreenStageInformation in/rayo 1x2.png",
		InitCommand=function(self)
			self:Center()
			self:SetAllStateDelays(0.082)
		end;
		OnCommand=cmd(accelerate,0.198;glowshift;diffusealpha,0);
};

t[#t+1] = LoadActor("../ScreenStageInformation in/bottom_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-27);
	OnCommand=cmd(accelerate,0.198;addy,54);
};

t[#t+1] = LoadActor("../ScreenStageInformation in/top_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_TOP+52);
	OnCommand=cmd(accelerate,0.198;addy,-104);
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	OnCommand=function(self)
		if GAMESTATE:GetPlayMode() == 'PlayMode_Regular' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle' or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			self:Load(THEME:GetPathG("ScreenStageInformation", "Stage " .. ToEnumShortString(sStage) ));
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:Load(THEME:GetPathG("ScreenStageInformation", "Stage oni"));
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
			self:Load(THEME:GetPathG("ScreenStageInformation", "Stage Nonstop"));
		elseif (GAMESTATE:Env()).EndlessState then
			self:Load(THEME:GetPathG("ScreenStageInformation", "Stage endless"));
		end;
	self:sleep(0.8)
	:linear(0.1):diffusealpha(0);
	end;
	};
};

return t;

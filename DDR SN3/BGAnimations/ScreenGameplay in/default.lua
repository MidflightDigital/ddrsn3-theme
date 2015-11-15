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
		
		LoadActor("../Door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y;zoom,1.01;halign,1);
		OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X-SCREEN_WIDTH);
	};

};
t[#t+1] =Def.ActorFrame{
		
		LoadActor("../Door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-50;y,SCREEN_CENTER_Y;zoom,1.01;halign,0);
		OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X+SCREEN_WIDTH);
	};

};

t[#t+1] = Def.ActorFrame {

		LoadActor( THEME:GetPathG("ScreenStageInformation", "Stage " .. ToEnumShortString(sStage) ) ) .. {
		InitCommand=cmd(Center);
		OnCommand=cmd(sleep,0.484;linear,0.198;diffusealpha,0);
	};	
};

return t;
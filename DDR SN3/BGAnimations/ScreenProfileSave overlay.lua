local x = Def.ActorFrame{};
if GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2() then
x[#x+1] = Def.ActorFrame {
	LoadActor(("cleared"))..{
		StartTransitioningCommand=cmd(play);
	};
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		OnCommand=cmd(play);
	};
	LoadActor("Extradoor1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;CenterY;zoom,1.01;halign,1);
		OnCommand=cmd(linear,0.5;x,SCREEN_CENTER_X+50;);
	};
	LoadActor("Extradoor2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;CenterY;zoom,1.01;halign,0);
		OnCommand=cmd(linear,0.5;x,SCREEN_CENTER_X-50;);
	};
	LoadActor("Extratitle")..{
		InitCommand=cmd(zoom,1;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(diffusealpha,0;zoomx,4;zoomy,0;accelerate,0.132;zoomx,1;zoomy,1;diffusealpha,1;sleep,1;accelerate,0.132;zoomx,4;zoomy,0;diffusealpha,0);
	};
}
end


--XXX: This file needs more modifications, this is just a quick Make It Work Right Now hack
local function SaveRadarValue( PlayerUID, ActualValue, CurrentValue, StyleWord, CataNumber, This )
    local styleMappings = {S='single',D='double'}
    local categoryMappings = {'stream','voltage','air','freeze','chaos'}
	CurrentValue = tonumber(ProfileData.GetRadarData(This,styleMappings[StyleWord],categoryMappings[tonumber(CataNumber)]))
    --I didn't bother looking at whatever this did but it seemed important
    if ActualValue > CurrentValue then
        CurrentValue = CurrentValue +(ActualValue-CurrentValue)/10;
    end
    ProfileData.SetRadarData(This,styleMappings[StyleWord],categoryMappings[tonumber(CataNumber)],CurrentValue)
end

--Save My Groove Radar Values
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then

local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID();
local myProfile = PROFILEMAN:GetProfile(PLAYER_1)

local StreamActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarActual():GetValue("RadarCategory_Stream"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarPossible():GetValue("RadarCategory_Stream"));
local VoltageActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarActual():GetValue("RadarCategory_Voltage"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarPossible():GetValue("RadarCategory_Voltage"));
local AirActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarActual():GetValue("RadarCategory_Air"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarPossible():GetValue("RadarCategory_Air"));
local FreezeActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarActual():GetValue("RadarCategory_Freeze"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarPossible():GetValue("RadarCategory_Freeze"));
local ChaosActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarActual():GetValue("RadarCategory_Chaos"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P1"):GetRadarPossible():GetValue("RadarCategory_Chaos"));


local StreamCurrentValue = 0;
local VoltageCurrentValue = 0;
local AirCurrentValue = 0;
local FreezeCurrentValue = 0;
local ChaosCurrentValue = 0;

	if not GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentStyle():GetStepsType() == 'StepsType_Dance_Single' then ---------Single
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"S","1",myProfile);
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"S","2",myProfile);
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"S","3",myProfile);
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"S","4",myProfile);
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"S","5",myProfile);
		else-----------------------Double
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"D","1",myProfile);
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"D","2",myProfile);
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"D","3",myProfile);
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"D","4",myProfile);
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"D","5",myProfile);
		end
	end;
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then

local PlayerUID = PROFILEMAN:GetProfile(PLAYER_2):GetGUID();
local myProfile = PROFILEMAN:GetProfile(PLAYER_2)

local StreamActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarActual():GetValue("RadarCategory_Stream"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarPossible():GetValue("RadarCategory_Stream"));
local VoltageActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarActual():GetValue("RadarCategory_Voltage"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarPossible():GetValue("RadarCategory_Voltage"));
local AirActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarActual():GetValue("RadarCategory_Air"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarPossible():GetValue("RadarCategory_Air"));
local FreezeActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarActual():GetValue("RadarCategory_Freeze"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarPossible():GetValue("RadarCategory_Freeze"));
local ChaosActualValue = (STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarActual():GetValue("RadarCategory_Chaos"))*(STATSMAN:GetCurStageStats():GetPlayerStageStats("PlayerNumber_P2"):GetRadarPossible():GetValue("RadarCategory_Chaos"));

local StreamCurrentValue = 0;
local VoltageCurrentValue = 0;
local AirCurrentValue = 0;
local FreezeCurrentValue = 0;
local ChaosCurrentValue = 0;
	if not GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetCurrentStyle():GetStepsType() == 'StepsType_Dance_Single' then ---------Single
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"S","1",myProfile);
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"S","2",myProfile);
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"S","3",myProfile);
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"S","4",myProfile);
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"S","5",myProfile);
		else-----------------------Double
			SaveRadarValue(PlayerUID,StreamActualValue,StreamCurrentValue,"D","1",myProfile);
			SaveRadarValue(PlayerUID,VoltageActualValue,VoltageCurrentValue,"D","2",myProfile);
			SaveRadarValue(PlayerUID,AirActualValue,AirCurrentValue,"D","3",myProfile);
			SaveRadarValue(PlayerUID,FreezeActualValue,FreezeCurrentValue,"D","4",myProfile);
			SaveRadarValue(PlayerUID,ChaosActualValue,ChaosCurrentValue,"D","5",myProfile);
		end
	end;
end;




x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(0.5); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};


return x;
local x = Def.ActorFrame{};
x[#x+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,80;diffuse,color("0,0,0,0.0"));
		OnCommand=cmd(smooth,0.2;diffuse,color("0,0,0,0.5"));
		OffCommand=cmd(smooth,0.2;diffuse,color("0,0,0,0.0"));
	};
	LoadFont("Common Normal")..{
		Text=ScreenString("Saving Profiles");
		InitCommand=cmd(Center;diffuse,color("1,1,1,1");shadowlength,1);
		OffCommand=cmd(linear,0.15;diffusealpha,0);
	};
};
if GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2() then
x[#x+1] = Def.ActorFrame {

	LoadActor("RDAdoorALL")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
		OffCommand=cmd(sleep,0.15;);
	};
	LoadActor("flowerLL")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OffCommand=cmd(linear,0.25;x,SCREEN_CENTER_X);
		
	};
	LoadActor("flowerRR")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OffCommand=cmd(linear,0.25;x,SCREEN_CENTER_X);
	};
	LoadActor("RDAtitle.png")..{
		InitCommand=cmd(zoom,1;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OffCommand=cmd(linear,0.1;zoom,1);
	};
}
end


local function SaveRadarValue( PlayerUID, ActualValue, CurrentValue, StyleWord, CataNumber, This )
	local user = This:GetUserTable()
	local RadarFile = RageFileUtil:CreateRageFile();
	if RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",1) then 
		local str = RadarFile:Read();
		CurrentValue = tonumber(str);
		RadarFile:Close();	
	else
		RadarFile:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",2);
		RadarFile:Write("0.0");
		RadarFile:Close();	
	end
	
	-- if ActualValue > CurrentValue+0.005 then
		-- if (ActualValue-CurrentValue)/20 > 0.05 then
			-- CurrentValue = CurrentValue + 0.05;
		-- elseif  (ActualValue-CurrentValue)/20 < 0.005 then
			-- CurrentValue = CurrentValue + 0.005;
		-- else
			-- CurrentValue = CurrentValue +(ActualValue-CurrentValue)/20;
		-- end
	-- elseif ActualValue > CurrentValue then
		-- CurrentValue = ActualValue;  --If value is very close (difference in 0.005) then new radar value = ActualValue
	-- end
	if ActualValue > CurrentValue then
		CurrentValue = CurrentValue +(ActualValue-CurrentValue)/10;
	end
	RadarFile:Close();	
	
	user["DDRSN3Radar"..StyleWord..CataNumber] = CurrentValue
	local RadarFile2 = RageFileUtil:CreateRageFile();
	RadarFile2:Open("Save/MyGrooveRadar/"..PlayerUID.."_"..StyleWord..CataNumber..".txt",2);
	RadarFile2:Write(tostring(CurrentValue));
	RadarFile2:Close();
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
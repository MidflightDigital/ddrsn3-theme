--[[
This script was taken from KENp's DDR X2 theme
and was recoded by FlameyBoy and Inorizushi
]]--

local ProfileInfoCache = {}
setmetatable(ProfileInfoCache, {__index = 
function(table, ind) 
    local out = {}
    local prof = PROFILEMAN:GetLocalProfileFromIndex(ind-1) 
    out.SongsAndCoursesPercentCompleteAllDifficultiesSingle = prof:GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single')
    out.SongsAndCoursesPercentCompleteAllDifficultiesDouble = prof:GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double')
    out.TotalCaloriesBurned = prof:GetTotalCaloriesBurned()
    out.CaloriesBurnedToday = prof:GetCaloriesBurnedToday()
    out.LastPlayedSong = prof:GetLastPlayedSong()
    out.DisplayName = prof:GetDisplayName()
    out.NumTotalSongsPlayed = prof:GetNumTotalSongsPlayed()
    out.UserTable = prof:GetUserTable()
    ProfileData.GetRadarData(prof,'single','chaos')
    rawset(table, ind, out)
    return out
end
})

--卡片內容物件---------------------------
function LoadCard(cColor,cColor2,Player,IsJoinFrame)
	local t = Def.ActorFrame {
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardBackground") ) .. {
			InitCommand=cmd(shadowlength,0;zoomy,0;diffuse,cColor);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoomy,1;);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				end
			end;
		};
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","LvWord") ) .. {
			InitCommand=cmd(shadowlength,0;zoom,0;y,46;x,18;diffuse,cColor2);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.5;);
			OffCommand=cmd(linear,0.02;zoom,0.100;diffusealpha,0);
		};
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","DancerNameWord") ) .. {
			InitCommand=cmd(shadowlength,0;zoom,0;y,-60;x,-24;diffuse,cColor2;);
			OnCommand=cmd(sleep,0.3;linear,0.3;zoom,0.4;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
		};
		
			--上下框架------------
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardFrameA") )..{
			Name = "Frame";
			InitCommand=cmd(y,0;zoomx,0);
			OnCommand=cmd(linear,0.3;zoomx,1;linear,0.3;y,-83);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;y,0.100;linear,0.2;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;y,0.100;linear,0.2;diffusealpha,0))(self);
				end
			end;
			
		};
	};

	return t
end

function LoadPlayerStuff(Player)
	
	local t = {};
	local pn = (Player == PLAYER_1) and 1 or 2;


	t[#t+1] = Def.ActorFrame {
		Name = 'JoinFrame';
		LoadCard(Color('Outline'),color('0,0,0,0'),Player,true);

		LoadActor( THEME:GetPathG("ScreenSelectProfile","Start") ) .. {
			InitCommand=cmd(zoomy,0;diffuseshift;effectcolor1,Color('White');effectcolor2,color("#A5A6A5"));
			OnCommand=cmd(zoomy,0;zoomx,0;sleep,0.5;linear,0.1;zoomx,0.5;zoomy,0.5);
			OffCommand=cmd(sleep,0.5;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
	};
	
	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,false);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,5);
		
		LoadActor( THEME:GetPathG("ScreenDataSaveSummary","MyGrooveRadarBackP1") )..{
			InitCommand=cmd(zoom,0.4;y,-2.5);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};
	};
	t[#t+1] = Def.ActorScroller{
		Name = 'Scroller';
		NumItemsToDraw=1;

		OnCommand=cmd(draworder,1000;y,5;SetFastCatchup,true;SetMask,0,29;SetSecondsPerItem,0.15);
		TransformFunction=function(self, offset, itemIndex, numItems)
			local focus = scale(math.abs(offset),0,2,1,0);
			self:visible(false);
			self:y(math.floor( offset*20 ));

		end;
	};
	
	
	t[#t+1] = Def.ActorFrame {
		Name = "EffectFrame";
	};
	
	--下方卡片-----------------
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileText';
		InitCommand=cmd(y,-48;zoom,0.6;shadowlength,1;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,400);
		OnCommand=cmd(sleep,0.8;linear,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.01;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileLevel';
		InitCommand=cmd(valign,1;x,55;y,52;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("0.1,1,0.1,1");strokecolor,Color("Outline");maxwidth,50);
		OnCommand=cmd(sleep,0.7;linear,0.05;diffusealpha,1;zoom,0.6);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectedTotalCaloriesBurned';
		InitCommand=cmd(x,33.5;y,60;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.3);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectSongsPlayed';
		InitCommand=cmd(x,25;y,-56;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,150);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	

	
	t[#t+1] = Def.Sprite{
		Name = 'selectedMostSongPlayed';
		InitCommand=cmd(x,65;y,-32;zoom,0;scaletoclipped,0,0;);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;diffuse,color("1,1,1,1");scaletoclipped,40,40;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBarBack';
			InitCommand=cmd(diffusealpha,0;y,46;x,-2;zoomx,0.5;halign,1);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
	};
	
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBar';
			InitCommand=cmd(diffusealpha,0;y,46;x,-2;zoomx,0.5;halign,1);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
		};
		
	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectTotalCalWord';
		InitCommand=cmd(x,-26;y,60;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Calories burned today:");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.3))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};


	t[#t+1] =LoadFont("_handelgothic bt 20px") .. {
		InitCommand=cmd(x,0;y,-83;zoom,0;diffuse,color("1,1,1,1");maxwidth,270);
		OnCommand=function(self)
			if Player== PLAYER_1 then
				self:settext("PLAYER 1");
				self:diffuse(color("#00ff30"));
			else
				self:settext("PLAYER 2");
				self:diffuse(color("#00ff30"));
			end
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.5))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};	
	------MyGrooveRadar
	if (Player == PLAYER_1) then
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,PLAYER_1,'single')..{
			Name = "GVRD1S";
			InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,-25;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S2';
			InitCommand=cmd(horizalign,right;x,-56+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S3';
			InitCommand=cmd(horizalign,right;x,-50+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S4';
			InitCommand=cmd(horizalign,right;x,50+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S5';
			InitCommand=cmd(horizalign,right;x,50+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		
	else
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,PLAYER_2,'single')..{
			Name = "GVRD2S";
			InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};	
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,-25;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S2';
			InitCommand=cmd(horizalign,right;x,-56+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S3';
			InitCommand=cmd(horizalign,right;x,-50+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S4';
			InitCommand=cmd(horizalign,right;x,50+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S5';
			InitCommand=cmd(horizalign,right;x,50+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
	end;
	
	

	return t;
end;

function UpdateInternal3(self, Player)
    
	local pn = (Player == PLAYER_1) and 1 or 2;
	local frame = self:GetChild(string.format('P%uFrame', pn));
	local scroller = frame:GetChild('Scroller');
	local seltext = frame:GetChild('SelectedProfileText');
	local joinframe = frame:GetChild('JoinFrame');
	local smallframe = frame:GetChild('SmallFrame');
	local bigframe = frame:GetChild('BigFrame');
	local selLevel = frame:GetChild('SelectedProfileLevel');
	local selTotalCalWord = frame:GetChild('selectTotalCalWord');
	local selTotalCaloriesBurned = frame:GetChild('selectedTotalCaloriesBurned');
	local selMostSongPlayed = frame:GetChild('selectedMostSongPlayed');
	local selSongsPlayed = frame:GetChild('selectSongsPlayed');
	local selLvBarBack = frame:GetChild('selectLvBarBack');
	local selLvBar = frame:GetChild('selectLvBar');
	--MyGrooveRadar
	local selPlayerUID;
	local selGVRDSingle = (Player == PLAYER_1) and frame:GetChild('GVRD1S') or frame:GetChild('GVRD2S');
	local selGVRDValue_S1 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S1') or frame:GetChild('GVRD2Value_S1');
	local selGVRDValue_S2 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S2') or frame:GetChild('GVRD2Value_S2');
	local selGVRDValue_S3 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S3') or frame:GetChild('GVRD2Value_S3');
	local selGVRDValue_S4 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S4') or frame:GetChild('GVRD2Value_S4');
	local selGVRDValue_S5 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S5') or frame:GetChild('GVRD2Value_S5');
	
	local PcntLarger;
	--local selMostCoursePlayed = frame:GetChild('selectedMostCoursePlayed');
	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true);
		if MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' then
			--using profile if any
			joinframe:visible(false);
			smallframe:visible(true);
			bigframe:visible(false);
			seltext:visible(true);
			scroller:visible(true);
			selLevel:visible(true);
			selTotalCalWord:visible(true);
			selTotalCaloriesBurned:visible(true);
			selMostSongPlayed:visible(false);
			selSongsPlayed:visible(false);
			selLvBarBack:visible(true);
			selLvBar:visible(true);
			selGVRDSingle:visible(true);
			selGVRDValue_S1:visible(true);
			selGVRDValue_S2:visible(true);
			selGVRDValue_S3:visible(true);
			selGVRDValue_S4:visible(true);
			selGVRDValue_S5:visible(true);
		
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);
			
			
			if ind > 0 then
				local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
				local PcntCompleteSingle = ProfileInfoCache[ind].SongsAndCoursesPercentCompleteAllDifficultiesSingle;
				local PcntCompleteDouble = ProfileInfoCache[ind].SongsAndCoursesPercentCompleteAllDifficultiesDouble;
				--HonorName
				
				if PcntCompleteSingle>PcntCompleteDouble then
					PcntLarger = PcntCompleteSingle;
				else 
					PcntLarger = PcntCompleteDouble;
				end
				PcntLarger = PcntLarger*100;
				
				local Lv = math.ceil(math.sqrt(ProfileInfoCache[ind].TotalCaloriesBurned));
				local pcnt =(ProfileInfoCache[ind].TotalCaloriesBurned-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
					--totalPcnt = PcntLarger;				
				--local pcnt =((ProfileInfoCache[ind].TotalCaloriesBurned-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				bigframe:visible(true);
				scroller:SetDestinationItem(ind-1);
				seltext:settext(ProfileInfoCache[ind].DisplayName);
				selLevel:settext(math.ceil(math.sqrt(ProfileInfoCache[ind].TotalCaloriesBurned) ));
				selTotalCaloriesBurned:settext(math.ceil(ProfileInfoCache[ind].CaloriesBurnedToday)..' kCals.');
				selMostSongPlayed:Load(GetSongGPath(ProfileInfoCache[ind].LastPlayedSong));
				selSongsPlayed:settext(tostring(math.ceil(ProfileInfoCache[ind].NumTotalSongsPlayed)));
				selLvBar:cropright(1-pcnt);
				
				local RadarValueTableSingle = {};
				local RadarValueTableDouble = {};
				
				----------Single Radar 
				--Stream--
				RadarValueTableSingle[1] = ProfileData.GetRadarData(profile, 'single', 'stream')
                selGVRDValue_S1:settext(string.format("%0.1f", RadarValueTableSingle[1]*100));
                --Voltage--
                RadarValueTableSingle[2] = ProfileData.GetRadarData(profile, 'single', 'voltage')
                selGVRDValue_S2:settext(string.format("%0.1f", RadarValueTableSingle[2]*100));
                --Air--
                RadarValueTableSingle[3] = ProfileData.GetRadarData(profile, 'single', 'air')
                selGVRDValue_S3:settext(string.format("%0.1f", RadarValueTableSingle[3]*100));
				--Freeze--
                RadarValueTableSingle[4] = ProfileData.GetRadarData(profile, 'single', 'freeze')
                selGVRDValue_S4:settext(string.format("%0.1f", RadarValueTableSingle[4]*100));
				--Chaos--
                RadarValueTableSingle[5] = ProfileData.GetRadarData(profile, 'single', 'chaos')
                selGVRDValue_S5:settext(string.format("%0.1f", RadarValueTableSingle[5]*100));

				-- Save the past values, which we will need later
				local pastValues = GetOrCreateChild(GAMESTATE:Env(), 'PastRadarValues')
				pastValues[Player] = DeepCopy(ProfileData.GetRadarTable(profile))
				
			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(Player, 1) then
					bigframe:visible(false);
					scroller:SetDestinationItem(0);
					self:queuecommand('UpdateInternal2');
				else
					joinframe:visible(false);
					smallframe:visible(false);
					bigframe:visible(false);
					scroller:visible(false);
					seltext:settext('No profile');
					selLevel:settext('No level info');
					selTotalCaloriesBurned:settext('No Played Songs Info');
					selMostSongPlayed:visible(false);
					selSongsPlayed:visible(false);
					selLvBarBack:visible(true);
					selLvBar:visible(false);
				
					selGVRDSingle:visible(false);
					selGVRDValue_S1:visible(false);
					selGVRDValue_S2:visible(false);
					selGVRDValue_S3:visible(false);
					selGVRDValue_S4:visible(false);
					selGVRDValue_S5:visible(false);
				end;
			end;
		else
			--using card
			smallframe:visible(false);
			scroller:visible(false);
			seltext:settext('CARD');
			SCREENMAN:GetTopScreen():SetProfileIndex(Player, 0);
		end;
	else
		joinframe:visible(true);
		scroller:visible(false);
		seltext:visible(false);
		smallframe:visible(false);
		bigframe:visible(false);
		selLevel:visible(false);
		selTotalCalWord:visible(false);
		selTotalCaloriesBurned:visible(false);
		selMostSongPlayed:visible(false);
		selSongsPlayed:visible(false);
		selLvBarBack:visible(false);
		selLvBar:visible(false);
		
		selGVRDSingle:visible(false);
		selGVRDValue_S1:visible(false);
		selGVRDValue_S2:visible(false);
		selGVRDValue_S3:visible(false);
		selGVRDValue_S4:visible(false);
		selGVRDValue_S5:visible(false);
	end;
end;

--主程式
local t = Def.ActorFrame {

	StorageDevicesChangedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			if not GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -1);
			else
				SCREENMAN:GetTopScreen():Finish();
			end;
		end;
		if params.Name == 'Up' or params.Name == 'Up2' or params.Name == 'DownLeft' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 1 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind - 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Down' or params.Name == 'Down2' or params.Name == 'DownRight' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 0 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind + 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Back' then
			if GAMESTATE:GetNumPlayersEnabled()==0 then
				SCREENMAN:GetTopScreen():Cancel();
			else
				MESSAGEMAN:Broadcast("BackButton");
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -2);
			end;
		end;
	end;

	PlayerJoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	PlayerUnjoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	OnCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	UpdateInternal2Command=function(self)
		UpdateInternal3(self, PLAYER_1);
		UpdateInternal3(self, PLAYER_2);
	end;

	children = {
		Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=cmd();
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					(cmd(zoomx,2;zoomy,0.15;linear,0.175;zoomy,2;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+20;zoom,2;);
			OnCommand=cmd();
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					(cmd(zoomx,2;zoomy,0.15;linear,0.175;zoomy,2;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_2);
		};
		-- sounds
		LoadActor( THEME:GetPathS("ScreenSelectProfile","in") )..{
			StartTransitioningCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","start") )..{
			StartButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			BackButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("ScreenOptions","change") )..{
			DirectionButtonMessageCommand=cmd(play);
		};
	};
};


return t;

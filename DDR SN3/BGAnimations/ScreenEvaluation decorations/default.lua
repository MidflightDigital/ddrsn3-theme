local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay");

t[#t+1] = LoadActor(THEME:GetPathG("","_footer/skip"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

if not GAMESTATE:IsCourseMode() then
t[#t+1] = Def.Quad{
	InitCommand=cmd(setsize,SCREEN_WIDTH,48;diffuse,color("0,0,0,1");fadeleft,0.75;faderight,0.75;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-80;zoomx,0;zoomy,1;diffusealpha,0.8;sleep,0.000;);
	OnCommand=cmd(sleep,0.333;decelerate,0.133;zoomy,1;diffusealpha,1;accelerate,0.033;zoomx,0.5;decelerate,0.033;zoomx,1);
	OffCommand=cmd(sleep,0.0000;sleep,0.333;decelerate,0.066;zoomx,0;diffusealpha,0);
};
t[#t+1] = StandardDecorationFromFileOptional("SongInformation","SongInformation") .. {
	BeginCommand=function(self)
		local SongOrCourse;
		if GAMESTATE:GetCurrentSong() then
			SongOrCourse = GAMESTATE:GetCurrentSong();
		elseif GAMESTATE:GetCurrentCourse() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
		else
			return
		end

	end;
	SetCommand=function(self)
		local c = self:GetChildren();
		local SongOrCourse;
		if GAMESTATE:GetCurrentSong() then
			SongOrCourse = GAMESTATE:GetCurrentSong();

			c.TextTitle:settext( SongOrCourse:GetDisplayMainTitle() or nil );
			c.TextSubtitle:settext( SongOrCourse:GetDisplaySubTitle() or nil );
			c.TextArtist:settext( SongOrCourse:GetDisplayArtist() or nil );

			if SongOrCourse:GetDisplaySubTitle() == "" then
				c.TextTitle:visible(true);
				c.TextTitle:y(-16.5/2);
				c.TextSubtitle:visible(false);
				c.TextSubtitle:y(0);
				c.TextArtist:visible(true);
				c.TextArtist:y(18/2);
			else
				c.TextTitle:visible(true);
				c.TextTitle:y(-16.5);
				c.TextSubtitle:visible(true);
				c.TextSubtitle:y(0);
				c.TextArtist:visible(true);
				c.TextArtist:y(18);
			end
-- 			self:playcommand("Tick");
		elseif GAMESTATE:GetCurrentCourse() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();

			c.TextTitle:settext( SongOrCourse:GetDisplayMainTitle() or nil );
			c.TextSubtitle:settext( SongOrCourse:GetDisplaySubTitle() or nil );
			c.TextArtist:settext( SongOrCourse:GetDisplayArtist() or nil );

-- 			self:playcommand("Tick");
		else
			SongOrCourse = nil;

			c.TextTitle:settext("");
			c.TextSubtitle:settext("");
			c.TextArtist:settext("");

			self:playcommand("Hide")
		end
	end;
-- 	OnCommand=cmd(playcommand,"Set");
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	DisplayLanguageChangedMessageCommand=cmd(playcommand,"Set");
};
end;
-- judge labels
t[#t+1] = LoadActor("labels")..{
	InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+32;zoomy,0);
	OnCommand=cmd(linear,0.3;zoomy,1);
	OffCommand=cmd(sleep,0.2;linear,0.2;zoomy,0);
};

t[#t+1] = LoadActor("frame")..{
	InitCommand=cmd(diffusealpha,0.5;CenterX;y,SCREEN_CENTER_Y+35;zoomy,0);
	OnCommand=cmd(linear,0.3;zoomy,1);
	OffCommand=cmd(sleep,0.2;linear,0.2;zoomy,0);
};

-- difficulty display
if ShowStandardDecoration("DifficultyIcon") then
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		-- in rave mode, we always have two players.
	else
		-- otherwise, we only want the human players
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local diffIcon = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyIcon"), pn)
			t[#t+1] = StandardDecorationFromTable("DifficultyIcon" .. ToEnumShortString(pn), diffIcon);
		end
	end
end

t[#t+1] = LoadActor("../grade")..{
	OnCommand=cmd(play);
};

for pn in ivalues(PlayerNumber) do
	local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end
t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2();
	InitCommand=cmd(draworder,105);
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=cmd(play);
	};
};
t[#t+1] = LoadActor("grade")..{
	InitCommand=cmd(diffusealpha,1;draworder,100);
	OffCommand=cmd(sleep,0.2;linear,0.2;diffusealpha,0);
};

local stageXPos = {
	P1 = -200,
	P2 = 200
}

if GAMESTATE:IsCourseMode() then
	local function FindText(pss)
		SCREENMAN:SystemMessage("big ol wiener")
		if pss:GetFailed() then
			SCREENMAN:SystemMessage("aaah")
			return string.format("%02d STAGE",pss:GetSongsPassed())
		else
			return "CLEAR"
		end
	end
	for _, pn in pairs(GAMESTATE:GetHumanPlayers()) do
		local shortPn = ToEnumShortString(pn)
		t[#t+1] = Def.BitmapText{
			Font="_handelgothic bt 20px";
			InitCommand=cmd(x,stageXPos[shortPn];y,SCREEN_CENTER_Y+20);
			OnCommand=function(s)
				SCREENMAN:SystemMessage("wakey wakey")
				s:diffusealpha(0)
				:settext(FindText(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)))
				:sleep(0.8):diffusealpha(1)
			end;
		};
	end
end

return t

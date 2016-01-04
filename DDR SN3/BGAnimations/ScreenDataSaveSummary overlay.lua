local x = Def.ActorFrame{

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			SCREENMAN:GetTopScreen():Finish();
		end;
	end;

};



function SetRank02(Rank02, minValue)
	
	if minValue >=1.98 then
		Rank02 = "True God";
	elseif minValue >=1.80 then
		Rank02 = "Dazu God";
	elseif minValue >=1.60 then
		Rank02 = "God";
	elseif minValue >=1.40 then
		Rank02 = "Deity";
	elseif minValue >=1.20 then
		Rank02 = "Phoenix";
	elseif minValue >=1.00 then
		Rank02 = "Dragon";
	elseif minValue >=0.85 then
		Rank02 = "Emperor";
	elseif minValue >=0.70 then
		Rank02 = "King";
	elseif minValue >=0.55 then
		Rank02 = "Shogun";
	elseif minValue >=0.40 then
		Rank02 = "Noble";
	elseif minValue >=0.30 then
		Rank02 = "Knight";
	elseif minValue >=0.20 then
		Rank02 = "Samurai";
	elseif minValue >=0.10 then
		Rank02 = "Warrior";
	elseif minValue >0 then
		Rank02 = "Beginner";
	else
		Rank02 = "???";
		
	end
	
	return Rank02;
end


function SetRankFromRadarValue(selectRank, SingleTable, DoubleTable)
	local Rank01;
	local Rank02 = "123";

	local singleMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMax = math.max(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	local singleMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMin = math.min(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	
	local totalMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	-- local totalMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								-- DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	
	if totalMax == SingleTable[1] or totalMax==DoubleTable[1] then
		Rank01 = "Stream";
	elseif totalMax == SingleTable[2] or totalMax==DoubleTable[2] then
		Rank01 = "Voltage";
	elseif totalMax == SingleTable[3] or totalMax==DoubleTable[3] then
		Rank01 = "Air";
	elseif totalMax == SingleTable[4] or totalMax==DoubleTable[4] then
		Rank01 = "Freeze";
	else
		Rank01 = "Chaos";
	end
	
	if (totalMax == SingleTable[1] or 
		totalMax == SingleTable[2] or 
		totalMax == SingleTable[3] or 
		totalMax == SingleTable[4] or
		totalMax == SingleTable[5]) then
	
		Rank02 = SetRank02(Rank02,singleMin);
	else
		Rank02 = SetRank02(Rank02,doubleMin);
	end
	
	if Rank02 == "???" then
		Rank01 ="???"
	end

	selectRank:settext(Rank01.." ".. Rank02);
end;





function LoadPlayerStuff(Player)
	
	local t = {};
	local pn = (Player == PLAYER_1) and 1 or 2;
	local strpn = tostring(pn);

	-- t[#t+1] = Def.ActorFrame {
		-- Name = 'JoinFrame';
		-- LoadCard(Color('Outline'),color('0,0,0,0'),Player,true);

		
		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","Start") ) .. {
			-- InitCommand=cmd(shadowlength,0);
			-- OnCommand=cmd(diffuseshift;effectcolor1,Color('White');effectcolor2,color("#A5A6A5");playcommand,"Animate");
			-- AnimateCommand=cmd(smooth,0.1;zoomx,1.05;smooth,0.1;zoomx,1.0;queuecommand,"Animate");
			-- OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		-- };
		
	-- };
	
	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,true);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,48);
		
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,20,15;x,20;y,-35);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,20,15;x,-45;y,-20);
			OnCommand=cmd(diffusealpha,0;sleep,0.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,20,15;x,-40;y,15);
			OnCommand=cmd(diffusealpha,0;sleep,0.7;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,20,15;x,40;y,15);
			OnCommand=cmd(diffusealpha,0;sleep,0.8;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","MyGrooveRadarValueBack") )..{
			InitCommand=cmd(zoomto,20,15;x,45;y,-20);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		LoadActor( THEME:GetPathG("ScreenDataSaveSummary","MyGrooveRadarBackP"..strpn) )..{
			InitCommand=cmd(zoom,0.4;y,-2.5;);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};
		
		

	};
	
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileText';
		InitCommand=cmd(horizalign,left;x,-51;y,-71;zoom,0.6;shadowlength,0.5;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,400);
		OnCommand=cmd(sleep,0.8;linear,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.01;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileLevel';
		InitCommand=cmd(x,-45;y,-20;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("0.1,1,0.1,1");strokecolor,Color("Outline");maxwidth,50);
		OnCommand=cmd(sleep,0.7;linear,0.05;diffusealpha,1;zoomy,0.8;zoomx,1;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectedTotalCaloriesBurned';
		InitCommand=cmd(x,33.5;y,-21;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.25;zoomx,0.2;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectSongsPlayed';
		InitCommand=cmd(x,25;y,-56;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,150);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectHonorName';
		InitCommand=cmd(horizalign,center;skewx,-0.35;x,25;y,-57.5;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.8,1");strokecolor,Color("Outline");maxwidth,200);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.3;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	

	
	t[#t+1] = Def.Sprite{
		Name = 'selectedMostSongPlayed';
		InitCommand=cmd(x,32.5;y,-16;zoom,0;scaletoclipped,20,20);
		OnCommand=cmd(sleep,1.9;linear,0.05;diffusealpha,1;diffuse,color("1,1,1,1");zoom,0.5;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	
		t[#t+1] = Def.Sprite{
		Name = 'selectedHonorPic';
		InitCommand=cmd(x,37.5;y,-74.5;zoom,0;scaletoclipped,0,0;);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;scaletoclipped,25,25;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBarBack';
			InitCommand=cmd(diffusealpha,0;y,0;x,-2);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
	};
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBar';
			InitCommand=cmd(diffusealpha,0;y,0;x,-2);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
		};
	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectTotalAttackrateWord';
		InitCommand=cmd(x,-5;y,-31;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Achievement / ");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.25))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectPercentComplete';
		InitCommand=cmd(x,32.5;y,-31;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,220);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.25;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectTotalCalWord';
		InitCommand=cmd(x,-5;y,-21;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Today Burned / ");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.25))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectRank';
		InitCommand=cmd(x,10;y,-10;skewx,-0.35;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=function(self)
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.4))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectPlayerUID';
		InitCommand=cmd(x,20;y,-45;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.9,1");strokecolor,Color("Outline");maxwidth,420);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	

	t[#t+1] =LoadFont("_sveningsson Bold 60px") .. {
		InitCommand=cmd(x,0;y,-92.5;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,270;shadowlength,1.5);
		OnCommand=function(self)
			if Player== PLAYER_1 then
				self:settext("PLAYER:1");
				self:diffusebottomedge(ColorLightTone(PlayerColor(PLAYER_1)));
			else
				self:settext("PLAYER:2");
				self:diffusebottomedge(PlayerColor(PLAYER_2));
			end
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.125;zoomx,0.175))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	----MyGrooveRadar
	if (Player == PLAYER_1) then ---------------P1
		------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP1" ),0,0,0,0,0,1,0)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP1" ),1,0.2,0.2,0.2,0.5,2,0)..{
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		
		
		
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_N1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_N2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_N3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_N4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_N5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP1" ),0,0,0,0,0,1,1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP1" ),0,0,0,0,0,2,1)..{
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_O1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_O2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_O3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_O4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_O5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		
	else -----------P2
				------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP2" ),0,0,0,0,0,1,0)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP2" ),1,0.2,0.2,0.2,0.5,2,0)..{
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		
		
		
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_N4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_N5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP2" ),0,0,0,0,0,1,1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadarP2" ),0,0,0,0,0,2,1)..{
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
	end;
	
	

	return t;
end;

--Update Internal Stuff
function UpdateInternal(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local style = (GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single") and "S" or "D";
	local seltext = self:GetChild('SelectedProfileText');
	local joinframe = self:GetChild('JoinFrame');
	local smallframe = self:GetChild('SmallFrame');
	local bigframe = self:GetChild('BigFrame');
	local selLevel = self:GetChild('SelectedProfileLevel');
	local selTotalCaloriesBurned = self:GetChild('selectedTotalCaloriesBurned');
	local selectRank = self:GetChild('selectRank');
	local selectPlayerUID = self:GetChild('selectPlayerUID');
	local selMostSongPlayed = self:GetChild('selectedMostSongPlayed');
	local selHonorPic = self:GetChild('selectedHonorPic');
	local selHonorName = self:GetChild('selectHonorName');
	local selSongsPlayed = self:GetChild('selectSongsPlayed');
	local selLvBar = self:GetChild('selectLvBarBack');
	local selLvBar = self:GetChild('selectLvBar');
	local selPercentComplete = self:GetChild('selectPercentComplete');
	local selTotalAttackrateWord = self:GetChild('selectTotalAttackrateWord');
	local selPlayerUID;
	local selGVRD = (Player == PLAYER_1) and self:GetChild('GVRD1') or self:GetChild('GVRD2');
	local selGVRDP = (Player == PLAYER_1) and self:GetChild('GVRD1P') or self:GetChild('GVRD2P');
	local selGVRDValue_N1 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_N1') or self:GetChild('GVRD2Value_N1');
	local selGVRDValue_N2 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_N2') or self:GetChild('GVRD2Value_N2');
	local selGVRDValue_N3 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_N3') or self:GetChild('GVRD2Value_N3');
	local selGVRDValue_N4 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_N4') or self:GetChild('GVRD2Value_N4');
	local selGVRDValue_N5 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_N5') or self:GetChild('GVRD2Value_N5');
	local selGVRDValue_O1 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_O1') or self:GetChild('GVRD2Value_O1');
	local selGVRDValue_O2 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_O2') or self:GetChild('GVRD2Value_O2');
	local selGVRDValue_O3 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_O3') or self:GetChild('GVRD2Value_O3');
	local selGVRDValue_O4 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_O4') or self:GetChild('GVRD2Value_O4');
	local selGVRDValue_O5 = (Player == PLAYER_1) and self:GetChild('GVRD1Value_O5') or self:GetChild('GVRD2Value_O5');
	
	local PcntCompleteSingle = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single');
				local PcntCompleteDouble = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double');
				--HonorName
				
				if PcntCompleteSingle>PcntCompleteDouble then
					PcntLarger = PcntCompleteSingle;
				else 
					PcntLarger = PcntCompleteDouble;
				end
				PcntLarger = PcntLarger*100;
				
				if PcntLarger==0 then
					selHonorName:settext('--');
					selHonorPic:Load(THEME:GetPathB("","_ability/000"));
				elseif PcntLarger>=0 and PcntLarger<10 then
					selHonorName:settext('stone');
					if PcntLarger >8 then selHonorPic:Load(THEME:GetPathB("","_ability/008")); 
					elseif PcntLarger >6 then selHonorPic:Load(THEME:GetPathB("","_ability/006")); 
					elseif PcntLarger >4 then selHonorPic:Load(THEME:GetPathB("","_ability/004"));
					elseif PcntLarger >2 then selHonorPic:Load(THEME:GetPathB("","_ability/002")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/000")); 					
					end
				elseif PcntLarger>=10 and PcntLarger<20 then
					selHonorName:settext('soap bubble');
					if PcntLarger >18 then selHonorPic:Load(THEME:GetPathB("","_ability/018")); 
					elseif PcntLarger >16 then selHonorPic:Load(THEME:GetPathB("","_ability/016")); 
					elseif PcntLarger >14 then selHonorPic:Load(THEME:GetPathB("","_ability/014"));
					elseif PcntLarger >12 then selHonorPic:Load(THEME:GetPathB("","_ability/012")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/010")); 					
					end
				elseif PcntLarger>=20 and PcntLarger<30 then
					selHonorName:settext('pencil');
					if PcntLarger >28 then selHonorPic:Load(THEME:GetPathB("","_ability/028")); 
					elseif PcntLarger >26 then selHonorPic:Load(THEME:GetPathB("","_ability/026")); 
					elseif PcntLarger >24 then selHonorPic:Load(THEME:GetPathB("","_ability/024"));
					elseif PcntLarger >22 then selHonorPic:Load(THEME:GetPathB("","_ability/022")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/020")); 					
					end
				elseif PcntLarger>=30 and PcntLarger<40 then
					selHonorName:settext('macaron');
					if PcntLarger >38 then selHonorPic:Load(THEME:GetPathB("","_ability/038")); 
					elseif PcntLarger >36 then selHonorPic:Load(THEME:GetPathB("","_ability/036")); 
					elseif PcntLarger >34 then selHonorPic:Load(THEME:GetPathB("","_ability/034"));
					elseif PcntLarger >32 then selHonorPic:Load(THEME:GetPathB("","_ability/032")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/030")); 					
					end
				elseif PcntLarger>=40 and PcntLarger<50 then
					selHonorName:settext('lotus');
					if PcntLarger >48 then selHonorPic:Load(THEME:GetPathB("","_ability/048")); 
					elseif PcntLarger >46 then selHonorPic:Load(THEME:GetPathB("","_ability/046")); 
					elseif PcntLarger >44 then selHonorPic:Load(THEME:GetPathB("","_ability/044"));
					elseif PcntLarger >42 then selHonorPic:Load(THEME:GetPathB("","_ability/042")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/040")); 					
					end
				elseif PcntLarger>=50 and PcntLarger<60 then
					selHonorName:settext('beetle');
					if PcntLarger >58 then selHonorPic:Load(THEME:GetPathB("","_ability/058")); 
					elseif PcntLarger >56 then selHonorPic:Load(THEME:GetPathB("","_ability/056")); 
					elseif PcntLarger >54 then selHonorPic:Load(THEME:GetPathB("","_ability/054"));
					elseif PcntLarger >52 then selHonorPic:Load(THEME:GetPathB("","_ability/052")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/050")); 					
					end
				elseif PcntLarger>=60 and PcntLarger<70 then
					selHonorName:settext('jellyfish');
					if PcntLarger >68 then selHonorPic:Load(THEME:GetPathB("","_ability/068")); 
					elseif PcntLarger >66 then selHonorPic:Load(THEME:GetPathB("","_ability/066")); 
					elseif PcntLarger >64 then selHonorPic:Load(THEME:GetPathB("","_ability/064"));
					elseif PcntLarger >62 then selHonorPic:Load(THEME:GetPathB("","_ability/062")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/060")); 					
					end
				elseif PcntLarger>=70 and PcntLarger<80 then
					selHonorName:settext('hummingbird');
					if PcntLarger >78 then selHonorPic:Load(THEME:GetPathB("","_ability/078")); 
					elseif PcntLarger >76 then selHonorPic:Load(THEME:GetPathB("","_ability/076")); 
					elseif PcntLarger >74 then selHonorPic:Load(THEME:GetPathB("","_ability/074"));
					elseif PcntLarger >72 then selHonorPic:Load(THEME:GetPathB("","_ability/072")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/070")); 					
					end
				elseif PcntLarger>=80 and PcntLarger<90 then
					selHonorName:settext('kaleidoscope');
					if PcntLarger >88 then selHonorPic:Load(THEME:GetPathB("","_ability/088")); 
					elseif PcntLarger >86 then selHonorPic:Load(THEME:GetPathB("","_ability/086")); 
					elseif PcntLarger >84 then selHonorPic:Load(THEME:GetPathB("","_ability/084"));
					elseif PcntLarger >82 then selHonorPic:Load(THEME:GetPathB("","_ability/082")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/080")); 					
					end
				elseif PcntLarger>=90 and PcntLarger<100 then
					selHonorName:settext('prism');
					if PcntLarger >98 then selHonorPic:Load(THEME:GetPathB("","_ability/098")); 
					elseif PcntLarger >96 then selHonorPic:Load(THEME:GetPathB("","_ability/096")); 
					elseif PcntLarger >94 then selHonorPic:Load(THEME:GetPathB("","_ability/094"));
					elseif PcntLarger >92 then selHonorPic:Load(THEME:GetPathB("","_ability/092")); 
					else selHonorPic:Load(THEME:GetPathB("","_ability/090")); 					
					end
				elseif PcntLarger>=100  then
					selHonorName:settext('prism');
					selHonorPic:Load(THEME:GetPathB("","_ability/100"));
				end
				selHonorPic:shadowlength(1);
				
				local Lv = (math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())));
				local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
					--totalPcnt = PcntLarger;				
				--local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				bigframe:visible(true);
				seltext:settext(PROFILEMAN:GetProfile(Player):GetDisplayName());
				selLevel:settext(math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())) );
				selTotalCaloriesBurned:settext((math.ceil(PROFILEMAN:GetProfile(Player):GetCaloriesBurnedToday()))..' kCals.');
				selMostSongPlayed:Load(GetSongGPath(PROFILEMAN:GetProfile(Player):GetLastPlayedSong()));
				selMostSongPlayed:visible(false);
				--selSongsPlayed:settext(tostring(math.ceil(PROFILEMAN:GetProfile(Player):GetNumTotalSongsPlayed())));
				selLvBar:cropright(1-pcnt);
				--selPercentComplete:settext(string.format("%6.2f", totalPcnt*100).." %");
				selPercentComplete:settext(string.format("%6.2f", PcntLarger).." %");
				
				local selPlayerProf = PROFILEMAN:GetProfile(Player)
				selPlayerUID = selPlayerProf:GetGUID();

				local stype = GAMESTATE:GetCurrentStyle():GetStyleType()
				local style = ((stype == 'StyleType_OnePlayerTwoSides') or (stype == 'StyleType_TwoPlayersSharedSides'))
					and 'double'
					or 'single'
				
				selectPlayerUID:settext(string.upper(string.sub(selPlayerUID,1,4).."-"..string.sub(selPlayerUID,5,8)));
				local RadarFile = RageFileUtil:CreateRageFile()
				
				--New Radar Value
				--Stram--
				selGVRDValue_N1:settext(string.format("%0.1f", 
					ProfileData.GetRadarData(selPlayerProf, style, 'stream')*100));
				--Voltage--
				selGVRDValue_N2:settext(string.format("%0.1f", 
					ProfileData.GetRadarData(selPlayerProf, style, 'voltage')*100));
				--Air--
				selGVRDValue_N3:settext(string.format("%0.1f", 
					ProfileData.GetRadarData(selPlayerProf, style, 'air')*100));
				--Freeze--
				selGVRDValue_N4:settext(string.format("%0.1f", 
					ProfileData.GetRadarData(selPlayerProf, style, 'freeze')*100));
				--Chaos--
				selGVRDValue_N5:settext(string.format("%0.1f", 
					ProfileData.GetRadarData(selPlayerProf, style, 'chaos')*100));
				
				--Old Radar Value
				local env = GAMESTATE:Env()
				local pastVals = env.PastRadarValues
				local actualRadar = pastVals[Player][style]
				--Stream--
				selGVRDValue_O1:settext(string.format("%0.1f", actualRadar.stream*100));
				--Voltage--
				selGVRDValue_O2:settext(string.format("%0.1f", actualRadar.voltage*100));
				--Air--
				selGVRDValue_O3:settext(string.format("%0.1f", actualRadar.air*100));
				--Freeze--
				selGVRDValue_O4:settext(string.format("%0.1f", actualRadar.freeze*100));
				--Chaos--
				selGVRDValue_O5:settext(string.format("%0.1f", actualRadar.chaos*100));
				
				------Calculate Rank
				local RadarValueTableSingle = ProfileData.GetRadarDataPackaged(selPlayerProf, 'single');
				local RadarValueTableDouble = ProfileData.GetRadarDataPackaged(selPlayerProf, 'double');
				
				-----Rank From Radar Value
				SetRankFromRadarValue(selectRank,RadarValueTableSingle,RadarValueTableDouble);
end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
x[#x+1] = Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-260;y,SCREEN_CENTER_Y;zoom,1.5);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_1);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_1);
		};
end
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
x[#x+1] = Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+260;y,SCREEN_CENTER_Y;zoom,1.5);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_2);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_2);
		};
end


return x;
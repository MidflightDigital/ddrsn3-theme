local endless = (GAMESTATE:Env()).EndlessState ~= nil

local function EndlessScoreDisplayUpdate(self, _)
	local eState = (GAMESTATE:Env()).EndlessState
	self:GetChild("ScoreText"):settext(eState.scoring.getScoreString())
end

local t = Def.ActorFrame{
	LoadActor("mid")..{
		InitCommand=cmd(CenterX);
	};
	Def.TextBanner{
		InitCommand = function(self) self:Load("TextBannerGameplay")
        	:x(SCREEN_CENTER_X-100):y(-8)
			if GAMESTATE:IsAnExtraStage() then
				self:zoomy(-1)
			end
        	if GAMESTATE:GetCurrentSong() then
        		self:SetFromSong(GAMESTATE:GetCurrentSong())
        	end
        end;
        CurrentSongChangedMessageCommand = function(self)
        	self:SetFromSong(GAMESTATE:GetCurrentSong())
        end;
	};
};

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
--P1 Score Frame
t[#t+1]=Def.ActorFrame{
	InitCommand=cmd(addy,2);
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,192,24;diffuse,color("#666666"));
	};
	Def.Quad{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,190,20;diffuse,color("0,0,0,1"));
	};
};
	if endless then
		t[#t+1]=Def.ActorFrame{
			InitCommand=cmd(addy,24;SetUpdateFunction,EndlessScoreDisplayUpdate);
			Def.Quad{
				InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,352,24;diffuse,color("#666666"));
			};
			Def.Quad{
				InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,350,20;diffuse,color("0,0,0,1"));
			};
			Def.BitmapText{
				Font="ScoreDisplayNormal Text",
				Name="ScoreText",
				Text='0',
				InitCommand=function(s) s:x(SCREEN_LEFT+340):halign(1):diffuse(color "#F9FF20") end
			};
		};
	end
end;

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
t[#t+1]=Def.ActorFrame{
	InitCommand=cmd(addy,2);
	Def.Quad{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;setsize,192,24;diffuse,color("#666666"));
	};
	Def.Quad{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;setsize,190,20;diffuse,color("0,0,0,1"));
	};
};
	if endless then
		t[#t+1]=Def.ActorFrame{
			InitCommand=cmd(addy,24;SetUpdateFunction,EndlessScoreDisplayUpdate);
			Def.Quad{
				InitCommand=cmd(halign,1;x,SCREEN_RIGHT;setsize,352,24;diffuse,color("#666666"));
			};
			Def.Quad{
				InitCommand=cmd(halign,1;x,SCREEN_RIGHT;setsize,350,20;diffuse,color("0,0,0,1"));
			};
			Def.BitmapText{
				Font="ScoreDisplayNormal Text",
				Name="ScoreText",
				Text='0',
				InitCommand=function(s) s:x(SCREEN_RIGHT-340):halign(0):diffuse(color "#F9FF20") end
			};
		};
	end
end;

if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
t[#t+1]=Def.ActorFrame{
	LoadFont("_futura std medium 20px")..{
		InitCommand=function(self)
			self:settext("Level:")
			:halign(0):x(SCREEN_LEFT+40):y(2)
			:diffuse(color("#F9FF20"))
		end;
	};
	LoadFont("_futura std medium 20px")..{
		InitCommand=function(self)
			self:settext("Level:")
			:halign(1):x(SCREEN_RIGHT-80):y(2)
			:diffuse(color("#F9FF20"))
		end;
	};
};
end;

return t;

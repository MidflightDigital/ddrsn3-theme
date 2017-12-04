local t = Def.ActorFrame{}

function IsRDG()
	if GAMESTATE then
		local env = GAMESTATE:Env()
		if GAMESTATE:Env() then
			return true
		end
	end
end

--Common Objects
t[#t+1] = Def.ActorFrame{
	LoadFont("_handelgothic bt 40px")..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y-40;
		strokecolor,color("0,0,0,1");maxwidth,600
		diffusealpha,0.2);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				self:diffusealpha(0.5);
				self:settext(song:GetDisplayMainTitle());
			else
				self:diffusealpha(0);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
		OnCommand=cmd(vibrate,effectmagnitude,20,20,0);
	};
	LoadFont("_handelgothic bt 40px")..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y-40;
		strokecolor,color("0,0,0,1");maxwidth,600
		diffusealpha,0.2);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				self:diffusealpha(0.5);
				self:settext(song:GetDisplayMainTitle());
			else
				self:diffusealpha(0);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
		OnCommand=cmd(vibrate,effectmagnitude,-20,-20,0);
	};
	LoadFont("_handelgothic bt 40px")..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y-40;
		strokecolor,color("0,0,0,1");maxwidth,600);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				self:diffusealpha(1);
				self:settext(song:GetDisplayMainTitle());
			else
				self:diffusealpha(0);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
	};
	LoadActor("RDGDifficultyList.lua");
	Def.Quad{
		InitCommand=cmd(FullScreen);
		CurrentSongChangedMessageCommand=cmd(finishtweening;queuecommand,"Flash");
		FlashCommand=cmd(stoptweening;diffusealpha,1;sleep,0.2;decelerate,0.2;diffusealpha,0);
	};
	LoadActor("backer")..{
    InitCommand=cmd(Center);
  };
};


return t;

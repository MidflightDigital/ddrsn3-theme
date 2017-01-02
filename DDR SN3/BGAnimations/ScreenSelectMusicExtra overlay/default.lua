local t = Def.ActorFrame{}
--Common Objects
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_RIGHT-166;y,SCREEN_CENTER_Y-20);
    --Selection Arrows
	LoadActor("_selectarrow")..{
		InitCommand=cmd(x,-100;diffusealpha,1;draworder,1);
		OnCommand=cmd(bounce;effectmagnitude,8,0,0;effectclock,'beatnooffset');
		OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
	};

	LoadActor("_selectarrow")..{
		InitCommand=cmd(x,100;zoomx,-1;diffusealpha,1;draworder,1);
		OnCommand=cmd(bounce;effectmagnitude,-8,0,0;effectclock,'beatnooffset');
		OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y-80);
	OnCommand=cmd(addx,-200,decelerate,0.5;addx,200);
	OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,-200);
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	LoadActor("BannerFrame");
	Def.Banner{
		SetCommand=function(self)
		self:setsize(160,160);
		local song = GAMESTATE:GetCurrentSong();
			if song then
				if song:HasJacket() then
					self:Load(song:GetJacketPath());
					self:setsize(160,160);
				elseif song:HasBackground() then
					self:Load(song:GetBackgroundPath());
					self:setsize(160,160);
				elseif song:HasBanner() then
					self:Load(song:GetBannerPath());
					self:setsize(160,160);
				else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:setsize(160,160);
				end;
			end;
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(xy,SCREEN_LEFT+140,SCREEN_CENTER_Y+20;halign,0;zoom,0.6;maxwidth,200);
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
	LoadActor("bpmmeter.lua");
};

return t;

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center);
	Def.Banner {
		SetCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
		local song = GAMESTATE:GetCurrentSong();
			if song then
			self:CenterX();
				if song:HasBackground() then
					self:diffusealpha(1);
					self:LoadBackground(song:GetBackgroundPath());
					self:zoomtowidth(SCREEN_WIDTH);
					self:zoomtoheight(SCREEN_HEIGHT);
				end;
			end;
		else
			self:diffusealpha(0);
		end;
		self:stoptweening();
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
};

local factors = {201, 167, 135, 104, 75, 47, 21, -3, -28, -53, -79, -107, -136, -167, -199}

for i=1,15 do
	local ri = (i==9) and 8 or i	
	t[ri] = Def.ActorFrame {
		LoadActor( "w"..string.format("%02u", ri) )..{
			OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+factors[ri];addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
			OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
		};
	}
end

t[#t+1] = Def.ActorFrame {
	LoadActor("WheelHighlight.png")..{
		InitCommand=cmd(x,SCREEN_RIGHT-166;y,SCREEN_CENTER_Y-16);
		OnCommand=cmd(addx,330;sleep,0.6;decelerate,0.34;addx,-330);
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
	};
};

return t
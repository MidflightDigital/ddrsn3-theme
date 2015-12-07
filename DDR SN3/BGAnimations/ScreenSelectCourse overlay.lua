local t = Def.ActorFrame{
	LoadFont("Common Normal")..{
		Name="songTitle";
		InitCommand=cmd(halign,0;x,SCREEN_RIGHT-280;y,SCREEN_CENTER_Y-82;zoom,0.8;diffuse,color("#00ff11"););
		OnCommand=cmd(addx,400;sleep,0.264;decelerate,0.52;addx,-400;);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,400);
		SetCommand=function(self)
			local song;
			local tit="";
			if GAMESTATE:IsCourseMode() then
				song=GAMESTATE:GetCurrentCourse();
				tit=song:GetDisplayFullTitle();
			end;
			self:maxwidth(200/0.8);
			self:settextf("%s",tit);
		end;
	};
};

local function updateTitle(self)
	local upTit = self:GetChild("songTitle");
	local curSelection = GAMESTATE:GetCurrentSong();
	local curSelCourse = GAMESTATE:GetCurrentCourse();
	upTit:maxwidth(200/0.8);
	if curSelection or curSelCourse then
		local song;
		local tit="";
		if GAMESTATE:IsCourseMode() then
			song=GAMESTATE:GetCurrentCourse();
			tit=song:GetDisplayFullTitle();
			upTit:settextf("%s",tit);
		else
			song=GAMESTATE:GetCurrentSong();
			tit=song:GetDisplayMainTitle();
			upTit:settextf("%s",tit..sub);
		end;
		upTit:diffuse(color("#00ff11"));
		
	else
		upTit:settext("");
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,updateTitle);

return t
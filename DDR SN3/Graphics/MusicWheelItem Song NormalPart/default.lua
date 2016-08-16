local t = Def.ActorFrame {
	LoadActor("Backing");
--new song
LoadActor("../ScreenSelectMusic NewSong")..{
	InitCommand=cmd(x,-138;y,-25;finishtweening;draworder,1;visible,SCREENMAN:GetTopScreen() ~= "ScreenNetRoom");
	OnCommand=cmd(diffusealpha,0;sleep,1;diffusealpha,1);
	SetCommand=function(self,param)
		if param.Song then
			if PROFILEMAN:IsSongNew(param.Song) then
				self:visible(true);
			else
				self:visible(false);
			end
		else
			self:visible(false);
		end
	end;
};
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	table.insert(t, WheelLight(pn, true))
end

return t;
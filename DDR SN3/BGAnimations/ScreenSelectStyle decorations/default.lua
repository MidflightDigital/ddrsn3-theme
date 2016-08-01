local t = LoadFallbackB()


t[#t+1] = LoadActor(THEME:GetPathG("","_footer/confirm"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-71;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}
t[#t+1] = LoadActor(THEME:GetPathG("","_footer/select"))..{
	InitCommand=cmd(draworder,199;x,SCREEN_RIGHT-183;y,SCREEN_BOTTOM-35;);
	OnCommand=cmd(draworder,80;halign,1;addy,54;sleep,0.2;decelerate,0.2;addy,-54);
	OffCommand=cmd(decelerate,0.2;addy,54);
}

--Sets a table for our style choices.
local StyleChoices = {
	{ Name = "Single", style = "style,single;screen,"..Branch.AfterSelectStyle()},
	{ Name = "Versus", style = "style,versus;screen,"..Branch.AfterSelectStyle()},
	{ Name = "Doubles", style = "style,double;screen,"..Branch.AfterSelectStyle()},
};

local curIndex = 1

if SN3Debug then
t[#t+1] = Def.ActorFrame{
	Def.Actor{
		Name="InputHandler";
		MenuRightP1MessageCommand=function(self)
			curIndex = curIndex + 1
		end;
		MenuLeftP1MessageCommand=function(self)
			curIndex = curIndex - 1
		end;
	};
	Def.BitmapText{
		Font="Common Normal",
		InitCommand=function(self)
			self:xy(100,200)
		end;
		MenuRightP1MessageCommand=cmd(settext,(curIndex));
		MenuLeftP1MessageCommand=cmd(settext,(curIndex));
	},
};
end;

return t

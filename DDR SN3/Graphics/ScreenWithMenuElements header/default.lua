local screenName = Var "LoadingScreen"
local headerTextImage

--this should probably be a metric
if screenName == "ScreenSelectMusic" then
    headerTextImage = "Music.png"
elseif string.find(screenName, "Options") then
    headerTextImage = "Options.png"
elseif screenName == "ScreenSelectStyle" then
    headerTextImage = "Style.png"
elseif string.find(screenName, "Evaluation") then
    headerTextImage = "Results.png"
end


local out = Def.ActorFrame{
	LoadActor("base")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("time.png")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
	};
	LoadActor("time_ani")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12;diffusealpha,0.5);
		OnCommand=cmd(addy,-76;sleep,0.2;decelerate,0.2;addy,76;blend,Blend.Add;;spin;effectmagnitude,0,0,-200);
	};
}

if headerTextImage then
	SCREENMAN:SystemMessage("Adding")
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self) self:x(SCREEN_LEFT+95):y(5):halign(0):valign(1) end,
	})
	SCREENMAN:SystemMessage("Alive")
end

return out
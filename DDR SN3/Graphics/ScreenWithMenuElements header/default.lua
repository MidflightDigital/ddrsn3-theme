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
	LoadActor("time")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	};
	LoadActor("ani")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12;diffusealpha,0.5);
		OnCommand=cmd(addy,-76;sleep,0.2;decelerate,0.2;addy,76;blend,Blend.Add;;spin;effectmagnitude,0,0,-200);
		OffCommand=cmd(stopeffect;bouncebegin,0.25;zoom,0);
	};
}

if headerTextImage then
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self) self:x(SCREEN_LEFT+95):y(5):halign(0):valign(1) end,
	})
end

return out
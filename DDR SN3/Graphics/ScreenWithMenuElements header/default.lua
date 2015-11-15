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

local function UpdateAni(self)
	local timer = SCREENMAN:GetTopScreen():GetChild "Timer"
	local ani = self:GetChild "ani"
	if timer and ani then
		local time = timer:GetSeconds()
		local ftime = time - math.floor(time)
		ani:rotationz(360*ftime)
	end
end


local out = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateAni) end;
	LoadActor("base")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("time")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	};
}

if PREFSMAN:GetPreference("MenuTimer") == true then
	table.insert(out,LoadActor("ani")..{
		Name="ani";
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12;diffusealpha,0.5);
		OnCommand=cmd(addy,-76;sleep,0.2;decelerate,0.2;addy,76;blend,Blend.Add);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	})

end

if headerTextImage then
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self) self:x(SCREEN_LEFT+95):y(5):halign(0):valign(1) end,
	})
end

return out
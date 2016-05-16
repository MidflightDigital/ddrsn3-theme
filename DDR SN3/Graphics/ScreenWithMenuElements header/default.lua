local screenName = Var "LoadingScreen"
local headerTextImage

--this should probably be a metric
if screenName == "ScreenSelectMusic" then
    headerTextImage = "Music (doubleres).png"
elseif string.find(screenName, "Options") then
    headerTextImage = "Options (doubleres).png"
elseif screenName == "ScreenNetRoom" or screenName == "ScreenNetSelectMusic" or screenName == "ScreenSMOnlineLogin" then
    headerTextImage = "Online (doubleres).png"
elseif screenName == "ScreenMapControllers" then
	headerTextImage = "Options (doubleres).png"
elseif screenName == "ScreenSelectStyle" then
    headerTextImage = "Style (doubleres).png"
elseif screenName == "ScreenSelectPlayMode" or screenName == "ScreenSelectPlayCourseMode" then
    headerTextImage = "Mode (doubleres).png"
elseif screenName == "ScreenSelectCourse" then
    headerTextImage = "Course (doubleres).png"
elseif screenName == "ScreenSelectProfile" then
	headerTextImage = "profile (doubleres).png"
elseif screenName == "ScreenDataSaveSummary" then
	headerTextImage = "save (doubleres).png"
elseif screenName == "ScreenEvaluationNormal" then
	headerTextImage = "eval (doubleres).png"
elseif screenName == "ScreenEvaluationOni" then
	headerTextImage = "eval (doubleres).png"
elseif screenName == "ScreenNetEvaluation" then
	headerTextImage = "eval (doubleres).png"
end

local headerBaseImage

if screenName == "ScreenSelectProfile" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenDataSaveSummary" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenEvaluationNormal" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenEvaluationOni" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenNetEvaluation" then
	headerBaseImage = "centerbase (doubleres).png"
else
	headerBaseImage = "base (doubleres).png"
end

local function UpdateAni(self)
	local timer = SCREENMAN:GetTopScreen():GetChild "Timer"
	local ani = self:GetChild "ani"
	if timer and ani then
		local time = timer:GetSeconds()
		local ftime = time - math.floor(time)
		ani:rotationz(360*ftime)
	elseif timer then
		timer:visible(false)
		self:SetUpdateFunction(nil)
	end
end


local out = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateAni) end;
	LoadActor(headerBaseImage)..{
		InitCommand=function(self)
			if screenName == "ScreenSelectProfile" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10);
			elseif screenName == "ScreenEvaluationNormal" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10);
			elseif screenName == "ScreenEvaluationOni" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10);
			elseif screenName == "ScreenDataSaveSummary" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10);
			elseif screenName == "ScreenNetEvaluation" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10);
			else
				self:x(SCREEN_LEFT):halign(0);
			end;
		end;
	};
}

if PREFSMAN:GetPreference("MenuTimer") == true then
	table.insert(out,LoadActor("time")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	})
	table.insert(out,LoadActor("ani")..{
		Name="ani";
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12;diffusealpha,0.5);
		OnCommand=cmd(addy,-76;sleep,0.2;decelerate,0.2;addy,76;blend,Blend.Add);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	})
end

if headerTextImage then
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self)
			self:y(5):valign(1);
			if screenName == "ScreenSelectProfile" then
				self:x(SCREEN_CENTER_X):halign(0.5);
			elseif screenName == "ScreenEvaluationNormal" then
				self:x(SCREEN_CENTER_X):halign(0.5);
			elseif screenName == "ScreenEvaluationOni" then
				self:x(SCREEN_CENTER_X):halign(0.5);
			elseif screenName == "ScreenNetEvaluation" then
				self:x(SCREEN_CENTER_X):halign(0.5);
			elseif screenName == "ScreenDataSaveSummary" then
				self:x(SCREEN_CENTER_X):halign(0.5);
			else
				self:x(SCREEN_LEFT+40):halign(0);
			end;
		end;
	})
end

return out

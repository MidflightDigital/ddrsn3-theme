local screenName = Var "LoadingScreen"

local footerBaseImage

if screenName == "ScreenSelectProfile" or screenName == "ScreenDataSaveSummary" then
  footerBaseImage = "centered (doubleres).png"
else
  footerBaseImage = "rightbiased (doubleres).png"
end

local t = Def.ActorFrame{
  LoadActor(footerBaseImage)..{
    OnCommand=function(self)
      if screenName == "ScreenSelectProfile" or screenName == "ScreenDataSaveSummary" then
        self:x(SCREEN_CENTER_X):halign(0.5);
      else
        self:x(SCREEN_RIGHT):halign(1);
      end;
    end;
  };
};

if screenName == "ScreenSelectStyle" or screenName == "ScreenSelectPlayMode" then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/con-sel.lua"));
};
end

if screenName == "ScreenSelectMusic" or screenName == "ScreenSelectMusicExtra" or screenName == "ScreenSelectMusicStarter" then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/MusSel.lua"));
};
end

if screenName == "ScreenEvaluationNormal" or screenName == "ScreenEvaluationSummary" or screenName == "ScreenEvaluationOni" or screenName == "ScreenEvaluationNonstop" or screenName == "ScreenNetEvaluation"  then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/skip.lua"));
};
end

return t;

local t = Def.ActorFrame{};

--[[if GAMESTATE:GetEarnedExtraStage('EarnedExtraStage_Extra1') or GAMESTATE:GetEarnedExtraStage('EarnedExtraStage_Extra2') then
  if not STATSMAN:GetCurStageStats():AllFailed() then
    t[#t+1] = Def.ActorFrame{
      LoadActor("doorsex close");
    };
  end
else
  t[#t+1] = Def.ActorFrame{
    LoadActor("_evalOut")..{
      OnCommand=cmd(sleep,1);
  		OffCommand=cmd(play);
    };
  };
end;]]--
t[#t+1] = Def.ActorFrame{
  LoadActor("_evalOut")..{
    OnCommand=cmd(sleep,1);
    OffCommand=cmd(play);
  };
};
return t;

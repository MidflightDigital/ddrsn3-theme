local pref = PREFSMAN:GetPreference("Premium")
local premiumItem
if pref == 'Premium_DoubleFor1Credit' then premiumItem = "doubles"
elseif pref == 'Premium_2PlayersFor1Credit' then premiumItem = "joint"
end

return Def.ActorFrame{
	LoadActor(THEME:GetPathG("ScreenTitleJoin","Messages/_premium "..premiumItem))..{
		OnCommand=cmd(texcoordvelocity,0.35,0);
	}
};
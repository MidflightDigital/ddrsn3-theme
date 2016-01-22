local charP1 = GAMESTATE:GetCharacter('PlayerNumber_P1'):GetDisplayName();
local charP2 = GAMESTATE:GetCharacter('PlayerNumber_P2'):GetDisplayName();

local t = Def.ActorFrame {};

if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/ScreenGameplay toasty/" .. charP1 .. "/default.lua") and GAMESTATE:IsPlayerEnabled("PlayerNumber_P1") then
t[#t+1] = Def.ActorFrame {
	LoadActor("char.lua");
};
elseif FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/ScreenGameplay toasty/" .. charP2 .. "/default.lua") and GAMESTATE:IsPlayerEnabled("PlayerNumber_P2") then
t[#t+1] = Def.ActorFrame {
	LoadActor("char.lua");
};
end

return t

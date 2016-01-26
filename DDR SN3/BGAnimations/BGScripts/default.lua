local t = Def.ActorFrame{};

local charName = GAMESTATE:GetCharacter(GAMESTATE:GetMasterPlayerNumber()):GetDisplayName();
local rmax = 9;
local num = math.random(1);

if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory() .. "BGAnimations/BGScripts/" .. charName .. "_" .. num .. ".avi") then
	t[#t+1] = LoadActor( charName .. "_" .. num .. ".avi" )..{
		InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;);	
	};

end
	
return t;
	

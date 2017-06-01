SOUND:DimMusic(1,math.huge)
local t = LoadFallbackB();
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional("Footer","Footer");
t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
-- other items (balloons, etc.)


return t
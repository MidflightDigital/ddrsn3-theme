local Player = ...
if not Player then error("ScreenSelectMusic MeterFrame requires a Player") end

local frameFile = THEME:GetPathG("ScreenSelectMusic","MeterFrame/"..string.format("_frame p%d",Player==PLAYER_1 and 1 or 2))

return LoadActor(frameFile);
local imagePrefix, speed, isClose = ...
if not (imagePrefix	and speed and (isClose~=nil)) then
	Warn("_doors malfunction")
	Warn(debug.traceback())
	error("_doors parameter problem: check the log for a traceback")
end
local coordinates = {
	left = {starting=isClose and SCREEN_CENTER_X-SCREEN_WIDTH or SCREEN_CENTER_X+6, ending=isClose and SCREEN_CENTER_X+6 or SCREEN_CENTER_X-SCREEN_WIDTH },
	right = {starting=isClose and SCREEN_CENTER_X+SCREEN_WIDTH or SCREEN_CENTER_X-16, ending=isClose and SCREEN_CENTER_X-16 or SCREEN_CENTER_X+SCREEN_WIDTH }
}
local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("",imagePrefix..'1'))..{
		InitCommand=cmd(x,coordinates.left.starting;y,SCREEN_CENTER_Y;halign,1);
			OnCommand=cmd(accelerate,speed;x,coordinates.left.ending);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("",imagePrefix..'2'))..{
		InitCommand=cmd(x,coordinates.right.starting;y,SCREEN_CENTER_Y;halign,0);
			OnCommand=cmd(accelerate,speed;x,coordinates.right.ending);
		};
	};
};

return t
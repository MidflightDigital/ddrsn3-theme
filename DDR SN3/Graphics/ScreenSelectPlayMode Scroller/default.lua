local t = Def.ActorFrame {};
local gc = Var("GameCommand");
local max_stages = PREFSMAN:GetPreference( "SongsPerPlay" );
local index = gc:GetIndex();
local c = 0;
if index == 0 then
	c = 1;
elseif index == 1 then
	c = 1;
elseif index == 2 then
	c = 0;
elseif index == 3 then
	c = 0;
elseif index == 4 then
	c = 0;
end

local path = "_shared/SelMode/";
--------------------------------------
t[#t+1] = Def.ActorFrame {
	LoadActor(gc:GetName()..".lua");
  LoadActor( THEME:GetPathG("",path.."Titles/"..gc:GetName()) )..{
		GainFocusCommand=function(self)
			MESSAGEMAN:Broadcast("PlaySelection", {Choice=gc:GetName()})
		end;
	};
};

return t;

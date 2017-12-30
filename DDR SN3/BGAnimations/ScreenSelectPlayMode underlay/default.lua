
local t = Def.ActorFrame{
  --[[Def.Quad{
    InitCommand=cmd(setsize,SCREEN_WIDTH-20,5;CenterX;y,SCREEN_CENTER_Y;fadeleft,0.5;faderight,0.5;diffuse,color("0,0,0,1"));
    OnCommand=cmd(zoomx,0;sleep,0.5;decelerate,0.4;zoomx,1);
    OffCommand=cmd(sleep,0.2;decelerate,0.2;zoomx,0);
  };
  LoadActor("backer")..{
    InitCommand=cmd(Center);
    OnCommand=cmd(zoomy,0;decelerate,0.4;zoomy,1);
    OffCommand=cmd(sleep,0.2;decelerate,0.2;zoomy,0);
  };]]--
  --[[LoadActor("style mockup")..{
    InitCommand=cmd(Center);
  };]]--
  LoadActor("highlight")..{
    InitCommand=cmd(Center;setsize,SCREEN_WIDTH,92);
    OnCommand=cmd(cropright,0.5;cropleft,0.5;sleep,0.3;linear,0.3;cropleft,0;cropright,0);
    OffCommand=cmd(linear,0.1;diffusealpha,0);
  }
};

return t;

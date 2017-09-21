local t = Def.ActorFrame {
  Def.Sprite{
  	Texture="MusicWheelItem Song NormalPart/Normal/new 2x1 (doubleres).png";
  	InitCommand=cmd(finishtweening;draworder,1);
  	OnCommand=cmd(diffusealpha,0;sleep,1;diffusealpha,1);
  };
};

return t;

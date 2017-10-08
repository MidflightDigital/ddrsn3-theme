local env = GAMESTATE:Env()
local charP2Name = env.SNCharacterP2 or ""
local style = GAMESTATE:GetCurrentStyle():GetStyleType();

local t = Def.ActorFrame{};
if (charP2Name ~= "") then
  local charP2ComboA = Characters.GetAssetPath(charP2Name, "comboA.png")
  local charP2ComboB = Characters.GetAssetPath(charP2Name, "comboB.png")
  local charP2Combo100 = Characters.GetAssetPath(charP2Name, "combo100.png")
  local charP2Color = (Characters.GetConfig(charP2Name)).color
  local charP2Ver = (Characters.GetConfig(charP2Name)).version

t[#t+1] = Def.ActorFrame{
  ComboChangedMessageCommand=function(self, params)
    if params.Player ~= 'PlayerNumber_P2' then return end
    local tapsAndHolds = GAMESTATE:GetCurrentSteps(params.Player):GetRadarValues(params.Player)
    	:GetValue('RadarCategory_TapsAndHolds')
    local CurCombo = params.PlayerStageStats:GetCurrentCombo()
    if CurCombo == 0 then
    	return
    elseif CurCombo == math.floor(tapsAndHolds/2)
    	or CurCombo == math.floor(tapsAndHolds*0.9) then
      self:queuecommand("PopupB")
      self:queuecommand("Popup")
    elseif CurCombo % 100 == 0 then
      self:queuecommand("PopupC")
      self:queuecommand("Popup")
    elseif CurCombo == 20 or (CurCombo % 50 == 0) then
      self:queuecommand("PopupA")
      self:queuecommand("Popup")
    end;
  end;

------------------
-- Mask --
  Def.Sprite{
    InitCommand=function(self)
      self:clearzbuffer(true);
      self:zwrite(true);
      self:blend('BlendMode_NoEffect');
      if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			  self:Load(THEME:GetPathB("ScreenGameplay","underlay/Cutin/_Mask_up"));
		  else
			  self:visible(false);
		  end
	   end;
   };
-----------------------------
-- Cutin background --
LoadActor("Back") .. {
  InitCommand=function(self)
    self:setsize(200,480)
    self:diffusealpha(0)
    self:MaskDest();
  end;
	PopupCommand=function(self)
		self:finishtweening();
		self:linear(0.2);
		self:diffusealpha(1);
		self:diffuse(unpack(charP2Color));
		self:sleep(1);
		self:linear(0.2);
		self:diffusealpha(0);
	end;
};
---------------------------
-- 100 Combos character Sprite
Def.Sprite {
  InitCommand=function(self)
    self:MaskDest();
    self:diffusealpha(0);
    if charP2Ver <= 2 then
      self:setsize(200,480)
    else
      self:scaletoclipped(200,480)
    end;
    if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
      self:y(50)
    end
    self:Load(charP2ComboA)
  end;
  PopupACommand=function(self)
    if charP2Ver <= 2 then
		 self:finishtweening();
		 self:y(44);
		 self:sleep(0.1);
		 self:linear(0.1);
		 self:diffusealpha(1);
		 self:linear(1);
		 self:y(26);
		 self:linear(0.1);
		 self:diffusealpha(0);
   elseif charP2Ver == 3 then
      self:finishtweening();
  		self:addy(13);
  		self:sleep(0.1);
  		self:linear(0.1);
  		self:diffusealpha(1);
  		self:linear(1);
  		self:addy(-13);
  		self:linear(0.1);
  		self:diffusealpha(0);
    end;
	end;
	PopupBCommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
	PopupCCommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
};
----------------------------------------------------
--Character B (normal combo sprite)
Def.Sprite {
  InitCommand=function(self)
    self:MaskDest();
    self:diffusealpha(0);
    if charP2Ver <= 2 then
      self:setsize(200,480)
    else
      self:scaletoclipped(200,480)
    end;
    if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
      self:y(50)
    end
    self:Load(charP2ComboB)
  end;
  ----------- use for every 50hit  ex 50 150 250 350 comb etc..
	PopupBCommand=function(self)
    if charP2Ver <= 2 then
		 self:finishtweening();
		 self:y(44);
		 self:sleep(0.1);
		 self:linear(0.1);
		 self:diffusealpha(1);
		 self:linear(1);
		 self:y(26);
		 self:linear(0.1);
		 self:diffusealpha(0);
   elseif charP2Ver == 3 then
      self:finishtweening();
  		self:addy(13);
  		self:sleep(0.1);
  		self:linear(0.1);
  		self:diffusealpha(1);
  		self:linear(1);
  		self:addy(-13);
  		self:linear(0.1);
  		self:diffusealpha(0);
    end;
	end;
	PopupACommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
	PopupCCommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
};
----------------------------------------------------
--Character C (100 combo sprite)
Def.Sprite {
  InitCommand=function(self)
    self:MaskDest();
    self:diffusealpha(0);
    if charP2Ver <= 2 then
      self:setsize(200,480)
    else
      self:scaletoclipped(200,480)
    end;
    if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
      self:y(50)
    end
    self:Load(charP2Combo100)
  end;
  PopupCCommand=function(self)
		self:finishtweening();
		self:addy(13);
		self:sleep(0.1);
		self:linear(0.1);
		self:diffusealpha(1);
	 -- self:diffusebottomedge(CutInColor());
		self:linear(1);
		self:addy(-13);
		self:linear(0.1);
		self:diffusealpha(0);
	end;
	PopupACommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
	PopupBCommand=function(self)
		self:finishtweening();
		self:diffusealpha(0);
	end;
};

-- Light
Def.Quad{
	InitCommand=function(self)
		self:MaskDest()
		self:diffusetopedge(color("#000000"))
		self:diffusebottomedge(unpack(charP2Color))
		self:diffusealpha(0)
		self:blend('BlendMode_Add')
    self:setsize(200,480)
		if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			self:y(50)
		end
	end;
	PopupCommand=function(self)
		self:finishtweening();
		self:sleep(0);
		self:linear(0.2);
		self:diffusealpha(0.5);
		self:sleep(0.8);
		self:linear(0.2);
		self:diffusealpha(0);
	end;
};

Def.ActorFrame {
	InitCommand=function(self)
		self:MaskDest()
	--	self:diffuse(CutInColor())
		if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			self:y(50)
    end;
	end;
	-- Left 1
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.17);
			self:diffusealpha(1);
			self:x(-85);
			self:y(90);
			self:zoomx(0.7);
			self:zoomy(2.2);
			self:linear(0.4);
			self:y(-150);
			self:diffusealpha(0);
		end;
	};
	-- Right 1
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.17);
			self:diffusealpha(1);
			self:x(60);
			self:y(155);
			self:zoomx(0.95);
			self:zoomy(1.6);
			self:linear(0.4);
			self:y(-10);
			self:diffusealpha(0);
		end;
	};
	-- Center 2 Right
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.33);
			self:diffusealpha(1);
			self:x(10);
			self:y(150);
			self:zoomx(0.8);
			self:zoomy(1.75);
			self:linear(0.4);
			self:y(-30);
			self:diffusealpha(0);
		end;
	};
	-- Center 2 Left
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.33);
			self:diffusealpha(1);
			self:x(-40);
			self:y(210);
			self:zoomx(0.8);
			self:zoomy(1);
			self:linear(0.4);
			self:y(110);
			self:diffusealpha(0);
		end;
	};
	-- Right 3
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.53);
			self:diffusealpha(1);
			self:x(70);
			self:y(120);
			self:zoomx(0.6);
			self:zoomy(2.07);
			self:linear(0.4);
			self:y(-120);
			self:diffusealpha(0);
		end;
	};
	-- Left 3 big
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.5);
			self:diffusealpha(1);
			self:x(-75);
			self:y(-90);
			self:zoomx(1);
			self:zoomy(4.45);
			self:linear(0.4);
			self:y(-320);
			self:diffusealpha(0);
		end;
	};
	-- Left 4
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.63);
			self:diffusealpha(1);
			self:x(-75);
			self:y(85);
			self:zoomx(1.2);
			self:zoomy(2.2);
			self:linear(0.4);
			self:y(-150);
			self:diffusealpha(0);
		end;
	};
	-- Right 4 small
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.63);
			self:diffusealpha(1);
			self:x(40);
			self:y(185);
			self:zoomx(0.6);
			self:zoomy(1.1);
			self:linear(0.4);
			self:y(85);
			self:diffusealpha(0);
		end;
	};
	-- Right 5 big
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.86);
			self:diffusealpha(1);
			self:x(70);
			self:y(20);
			self:zoomx(0.9);
			self:zoomy(3);
			self:linear(0.4);
			self:y(-190);
			self:diffusealpha(0);
		end;
	};
	-- Left 5
	LoadActor("_Circles")..{
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add';vertalign,top);
		PopupCommand=function(self)
			self:finishtweening();
			self:sleep(0.86);
			self:diffusealpha(1);
			self:x(-30);
			self:y(150);
			self:zoomx(0.6);
			self:zoomy(1.7);
			self:linear(0.4);
			self:y(-25);
			self:diffusealpha(0);
		end;
	};
};
};
end;

return t;

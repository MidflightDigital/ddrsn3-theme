local c;
local cf;
local cfInv;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local env = GAMESTATE:Env();
local starterMode = env.StarterMode == true;

--you can pass nil to this function, it acts the same as passing nothing
--however, i think that passing nil makes the intent clearer -tertu
local function cfShowOnly(...)
	local cfMembersToShow = {...}

	--build an inverse version of the argument table to speed up lookup
	local cfMTSInv = {}
	for _, name in pairs(cfMembersToShow) do
		cfMTSInv[name] = true
	end

	for name, a in pairs(cf) do
		--"if the name of this actor was passed, make it visible, otherwise
		--hide it"
		a:visible(cfMTSInv[name] == true)
	end
end

--this function causes any W1/W2/W3 combo to look like a W2 in starter
local function remapStarter(params)
	if starterMode then
		if params.FullComboW1 or params.FullComboW2 or params.FullComboW3 then
			params.FullComboW2 = true
			params.FullComboW1 = false
			params.FullComboW3 = false
		end
	end
end


local t = Def.ActorFrame {
	Def.ActorFrame {
		Name="ComboFrame";
		LoadFont( "combo", "marv" ) .. {
			Name="NumberW1";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "perf" ) .. {
			Name="NumberW2";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "great" ) .. {
			Name="NumberW3";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "normal") .. {
			Name="NumberNormal";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadActor("_combomarv") .. {
			Name="LabelW1";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_comboperfect") .. {
			Name="LabelW2";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_combogreat") .. {
			Name="LabelW3";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_combonormal") .. {
			Name="LabelNormal";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
	LoadActor(THEME:GetPathG("Combo","100Milestone")) .. {
		Name="OneHundredMilestone";
		InitCommand=cmd(visible,true);
		FiftyMilestoneCommand=cmd(playcommand,"Milestone");
	};
	LoadActor(THEME:GetPathG("Combo","1000Milestone")) .. {
		Name="OneThousandMilestone";
		InitCommand=cmd(visible,true);
		ToastyAchievedMessageCommand=cmd(playcommand,"Milestone");
	};
	};
	InitCommand = function(self)
		c = self:GetChildren();
		cf = c.ComboFrame:GetChildren();
		-- Inclu
		cfShowOnly(nil);
	end;
	ComboCommand=function(self, param)
		if param.Misses then
			cfShowOnly(nil);
			return;
		end
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			cfShowOnly(nil);
			return;
		end

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );

		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );

		cf.NumberW1:settext( string.format("%i", iCombo) );
		cf.NumberW2:settext( string.format("%i", iCombo) );
		cf.NumberW3:settext( string.format("%i", iCombo) );
		cf.NumberNormal:settext( string.format("%i", iCombo) );
		remapStarter(param);
		-- FullCombo Rewards
		if param.FullComboW1 then
			cfShowOnly('NumberW1', 'LabelW1');
		elseif param.FullComboW2 then
			cfShowOnly('NumberW2', 'LabelW2');
		elseif param.FullComboW3 then
			cfShowOnly('NumberW3', 'LabelW3');
		elseif param.Combo then
			cfShowOnly('NumberNormal', 'LabelNormal');
		else
			cfShowOnly('NumberNormal', 'LabelNormal');
		end
		-- Pulse
		Pulse( cf.NumberW1, param );
		Pulse( cf.NumberW2, param );
		Pulse( cf.NumberW3, param );
		Pulse( cf.NumberNormal, param );
		PulseLabel( cf.LabelW1, param );
		PulseLabel( cf.LabelW2, param );
		PulseLabel( cf.LabelW3, param );
		PulseLabel( cf.LabelNormal, param );
		-- Milestone Logic
	end;
};

return t;

local LoadingScreen = Var "LoadingScreen"

--this handles Back and Start for us because StepMania doesn't.
--If you want to add more navigation buttons, do it here.
local BasicNavigationHandler
do
	local transitioningOut = false
	BasicNavigationHandler=function(inputInfo)
		--once we're transitioning ignore input, otherwise it will start transitioning out once again.
		if transitioningOut then return true end
		local pn = inputInfo.PlayerNumber
		local gb = inputInfo.GameButton
		if pn and GAMESTATE:IsHumanPlayer(pn) and gb then
			local top = SCREENMAN:GetTopScreen()
			if gb == "Start" then
				transitioningOut = true
				SOUND:PlayOnce(THEME:GetPathS("Common", "start"), true)
				top:StartTransitioningScreen("SM_GoToNextScreen")
			elseif gb == "Back" then
				transitioningOut = true
				SOUND:PlayOnce(THEME:GetPathS("Common", "back"), true)
				top:StartTransitioningScreen("SM_GoToPrevScreen")
			end
		end
		return true
	end
end

local t = Def.ActorFrame{}

--Set up the input handler defined above. We have to do it at OnCommand time because the screen is
--initialized before it is the top screen.
t[#t+1] = Def.Actor{OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(BasicNavigationHandler) end}

--This is a helper function to make it easier to load metrics from the current screen definition.
local function m(metric,pn)
	if pn then
		metric = metric:gsub("PN", ToEnumShortString(pn))
	end
	return THEME:GetMetric(LoadingScreen,metric)
end

--As this screen pretty much exists to display PlayerStageStats, we'll need this a few times.
local PSSes = {}
do
	local stageStats = STATSMAN:GetCurStageStats()
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		PSSes[pn] = stageStats:GetPlayerStageStats(pn)
	end
end
--standard screen UI elements.
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional("Footer","Footer");
t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");

--Metric: RowsToShow
--This is a list of row defintions that the screen should use.
--They go onto the screen in the order they are declared in the metrics.
--Note that the names have no inherent connection to what piece of information they display.
local RowsToShow = split(',', m "RowsToShow")

--Metric: Row(row name)Condition
--filter out rows that should not be shown because of some bit of current status
--for example, a Row Condition can be GAMESTATE:ShowW1(), which will hide that row if W1s are disabled.
--These metrics are optional. If it is not present, the row is always shown.
for idx, name in ipairs(RowsToShow) do
	local condName = "Row"..name.."Condition"
	if THEME:HasMetric(LoadingScreen, condName) and (not m(condName)) then
		table.remove(RowsToShow, idx)
	end
end

local count = #RowsToShow

--The metrics define a number of properties, mostly about the central frame, but they
--implicitly affect a number of definitions.

local metrics = {}
--how tall each of the labels is
metrics.ITEM_HEIGHT = 19
--how much padding there is between each label
metrics.PADDING = 4
metrics.WIDTH = SCREEN_WIDTH
metrics.HEIGHT = (metrics.ITEM_HEIGHT+metrics.PADDING)*count-(metrics.PADDING)
--the absolute top of the shape
metrics.TOP = metrics.HEIGHT/2
--the absolute bottom of the shape
metrics.BOTTOM = -metrics.TOP
--the left edge of the tabs
metrics.TLEFT = -168
--the right edge of the tabs
metrics.TRIGHT = 168
--how wide the tab is in total
metrics.CORE = metrics.TRIGHT-metrics.TLEFT
--the top of the central rectangle of the shape
metrics.QTOP = metrics.TOP - metrics.ITEM_HEIGHT
--the bottom of the central rectangle of the shape
metrics.QBOTTOM = metrics.BOTTOM + metrics.ITEM_HEIGHT
--how thick the separator is
metrics.SEPARATOR_WIDTH = 1
--how far away the numbers should be from the label. 
metrics.NUM_OFFSET = m "NumberXOffset"

--The bannerframe is the banner, the frame that contains it, and graphics 
--that should be overlaid on it.
local bannerFrame = Def.ActorFrame{InitCommand=function(s) s:xy(m "BannerX",m "BannerY") end; OnCommand=cmd(zoomy,0;sleep,0.25;linear,0.15;zoomy,1);OffCommand=cmd(linear,0.15;zoomy,1);}
bannerFrame[#bannerFrame+1]=Def.Sprite{Texture=THEME:GetPathG("ScreenEvaluationNew", "bannerframe");}
bannerFrame[#bannerFrame+1]=Def.Banner{InitCommand=function(s) s:LoadFromSong(GAMESTATE:GetCurrentSong()):y(-10.5):setsize(256,80) end}
t[#t+1]=bannerFrame

--a bunch of things that should all be center-aligned more or less
--This includes the background shape, the actual judgment labels themselves, and all that.
local centerFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "JudgmentFrameX"):y(m "JudgmentFrameY") end,
	OnCommand=function(s) s:zoomy(0):sleep(0.25):linear(0.15):zoomy(1) end,
	OffCommand=function(s) s:linear(0.5):zoomy(0) end}
local labelPath = THEME:GetPathG("ScreenEvaluationNew", "rowlabels")

--the background
centerFrame[#centerFrame+1] = LoadActor("shape", metrics);
centerFrame[#centerFrame+1] = LoadActor("frame")..{
	InitCommand=cmd(zoom,1.2;y,4;diffusealpha,0.5);
};

--the actual judgment rows
--This goes through the rows in definition order and positions them.
for index, name in pairs(RowsToShow) do
	--row label
	--Metric: Row(row name)Frame
	--This selects the frame that should be displayed for this row from ScreenEvaluationNew rowlabels.
	--It starts from 0 in standard Sprite frame fashion.
	local baseY = metrics.BOTTOM+(metrics.ITEM_HEIGHT/2+(metrics.ITEM_HEIGHT+metrics.PADDING)*(index-1))
	centerFrame[#centerFrame+1] = Def.Sprite{
		Texture=labelPath,
		InitCommand=function(s)
			s:y(baseY):SetAllStateDelays(math.huge):setstate(m("Row"..name.."Frame"))
		end,
	}

	--row counter
	--This actually displays the value for this row.
	--Metric: Row(row name)Value
	--This calls a function with two arguments, the first being a PlayerStageStats
	--and the second being the player number that we are calculating. You usually
	--do not need the player number.
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		centerFrame[#centerFrame+1] = Def.RollingNumbers{
			Font="ScreenEvaluationNew rownumber",
			InitCommand= function(s) s:Load(m "RollingNumbersRowClass"):y(baseY)
				:x((pn=='PlayerNumber_P1' and -1 or 1)*metrics.NUM_OFFSET)
				:targetnumber((m("Row"..name.."Value"))(PSSes[pn],pn))
			end
		}
	end

	--separator line
	--This is drawn after every row except for the last.
	if index~=count then
		centerFrame[#centerFrame+1] = Def.Quad{
			InitCommand=function(s)
				s:y(baseY+metrics.ITEM_HEIGHT/2+metrics.PADDING/2):zoomy(metrics.SEPARATOR_WIDTH):zoomx(metrics.CORE)
				:diffuse{0,0,0,1}
			end,
		}
	end
end
--we will still add things to it but it should be below the grade and score
t[#t+1] = centerFrame

--Draw other player-specific things. This has to be done for non-human
--players also.
for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	local pss = PSSes[pn]
	--The grade area, Mostly defined in other actors which get a PlayerStageStats.
	--Metric: GradeXOffset
	--The absolute distance from the center that the grade should be positioned.
	local gradeFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "GradeXOffset"*(pn=='PlayerNumber_P1' and -1 or 1)+SCREEN_CENTER_X)
		:y(THEME:GetMetric(LoadingScreen,"GradeY")) end}
	gradeFrame[#gradeFrame+1] = LoadActor("fc_ring",pss)..{InitCommand=function(s) s:x(m("RingPNXOffset",pn)):y(m "RingYOffset") end}
	gradeFrame[#gradeFrame+1] = LoadActor("grade", pss)..{OnCommand= m"GradeOnCommand",OffCommand=m"GradeOffCommand"}
	if pss:FullCombo() then
		gradeFrame[#gradeFrame+1] = LoadActor("FullCombo 1x2")..{OnCommand=cmd(zoom,0;rotationz,360;sleep,0.5;linear,0.2;rotationz,0;zoom,1);OffCommand=cmd(linear,0.2;zoom,0)}
	end
	t[#t+1] = gradeFrame

	--score frame
	--This should be pretty self-explanatory, it's mostly positioning code but does have a couple
	--external actors it uses.
	local frameX = pn=='PlayerNumber_P1' and SCREEN_LEFT or SCREEN_RIGHT
	local onAddition = 246 * (pn=='PlayerNumber_P1' and -1 or 1)
	local offAddition = pn=='PlayerNumber_P1' and -SCREEN_WIDTH or SCREEN_WIDTH
	local scoreXOffset = m("ScoreXOffset") * (pn=='PlayerNumber_P1' and -1 or 1)
	local alignment = pn=='PlayerNumber_P1' and 0 or 1
	local frameZoomX = pn=='PlayerNumber_P1' and 1 or -1
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(xy,frameX,SCREEN_BOTTOM-104);
		OnCommand=cmd(addx,onAddition;sleep,0.2;linear,0.2;addx,-onAddition);
		OffCommand=cmd(linear,0.2;addx,offAddition);
		LoadActor("diff frame")..{
			InitCommand=cmd(halign,0;zoomx,frameZoomX);
		};
		LoadActor("difficon",pn)..{InitCommand=cmd(halign,alignment)};
		Def.ActorFrame{
			InitCommand=cmd(y,19);
			Def.Quad{
				InitCommand=cmd(halign,alignment;setsize,WideScale(192,256),24;diffuse,color("#666666"));
			};
			Def.Quad{
				InitCommand=cmd(halign,alignment;setsize,WideScale(190,254),20;diffuse,color("0,0,0,1"));
			};
			Def.RollingNumbers{
				Font="ScreenEvaluationNew scorenumber",
				InitCommand=function(s) s:halign(alignment):Load(m "RollingNumbersScoreClass"):zoomx(WideScale(1.2,1.6))
					:diffuse(color"#F9FF20"):targetnumber(pss:GetScore()):x(scoreXOffset) end
			};
		};
	};

	--This displays the player badge and whether the player got records.
	--Metrics used: PlayerXOffset (how far from the center the area is), 
	--BadgeYOffset (how far below the top of the black area the player badge should be)
	local playerZone=Def.ActorFrame{InitCommand=function(s) s:x((pn=='PlayerNumber_P1' and -1 or 1)*m "PlayerXOffset") end}
	playerZone[#playerZone+1] = LoadActor("badge "..ToEnumShortString(pn))..{InitCommand=function(s) s:y(-metrics.QTOP+m "BadgeYOffset") end}
	if pss:GetMachineHighScoreIndex() == 0 then
		playerZone[#playerZone+1] = LoadActor(THEME:GetPathG("Machine","Record2"))..{InitCommand=function(s) s:y(-metrics.QBOTTOM-36) end}
	end
	if pss:GetPersonalHighScoreIndex() == 0 then
		playerZone[#playerZone+1] = LoadActor(THEME:GetPathG("Machine","Record1"))..{InitCommand=function(s) s:y(-metrics.QBOTTOM-16) end}
	end
	centerFrame[#centerFrame+1]=playerZone
end

return t;

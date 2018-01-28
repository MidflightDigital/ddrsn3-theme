local LoadingScreen = Var "LoadingScreen"

--this handles Back and Start for us because StepMania doesn't
local BasicNavigationHandler
do
	local transitioningOut = false
	BasicNavigationHandler=function(inputInfo)
		--once we're transitioning ignore input
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

t[#t+1] = Def.Actor{OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(BasicNavigationHandler) end}

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
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional("Footer","Footer");
t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");

local RowsToShow = split(',', m "RowsToShow")
--filter out rows that should not be shown because of some bit of current status
--for example, RowW1Condition is GAMESTATE:ShowW1(), so if Marvelouses are disabled the row for them is not shown.
for idx, name in ipairs(RowsToShow) do
	local condName = "Row"..name.."Condition"
	if THEME:HasMetric(LoadingScreen, condName) and (not m(condName)) then
		table.remove(RowsToShow, idx)
	end
end
--used to calulate how tall the shape should be
local count = #RowsToShow

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
metrics.NUM_OFFSET = m "NumberXOffset"

local bannerFrame = Def.ActorFrame{InitCommand=function(s) s:xy(m "BannerX",m "BannerY") end}
bannerFrame[#bannerFrame+1]=Def.Sprite{Texture=THEME:GetPathG("ScreenEvaluationNew", "bannerframe")}
bannerFrame[#bannerFrame+1]=Def.Banner{InitCommand=function(s) s:LoadFromSong(GAMESTATE:GetCurrentSong()):y(-11):setsize(256,81) end}
t[#t+1]=bannerFrame

--a bunch of things that should all be center-aligned more or less
local centerFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "JudgmentFrameX"):y(m "JudgmentFrameY") end,
	OffCommand=function(s) s:linear(0.5):zoomy(0) end}
local labelPath = THEME:GetPathG("ScreenEvaluationNew", "rowlabels")

--the background
centerFrame[#centerFrame+1] = LoadActor("shape", metrics);

--the actual judgment rows
for index, name in pairs(RowsToShow) do
	--row label
	local baseY = metrics.BOTTOM+(metrics.ITEM_HEIGHT/2+(metrics.ITEM_HEIGHT+metrics.PADDING)*(index-1))
	centerFrame[#centerFrame+1] = Def.Sprite{
		Texture=labelPath,
		InitCommand=function(s)
			s:y(baseY):SetAllStateDelays(math.huge):setstate(m("Row"..name.."Frame"))
		end,
	}

	--row counter
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		centerFrame[#centerFrame+1] = Def.RollingNumbers{
			Font="ScreenEvaluationNew rownumber",
			InitCommand= function(s) s:Load(m "RollingNumbersRowClass"):y(baseY)
				:x((pn=='PlayerNumber_P1' and -1 or 1)*metrics.NUM_OFFSET)
				:targetnumber((m("Row"..name.."Value"))(PSSes[pn],pn))
			end
		}
	end

	--separator
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

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	local pss = PSSes[pn]
	local gradeFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "GradeXOffset"*(pn=='PlayerNumber_P1' and -1 or 1)+SCREEN_CENTER_X)
		:y(THEME:GetMetric(LoadingScreen,"GradeY")) end}
	gradeFrame[#gradeFrame+1] = LoadActor("fc_ring",pss)..{InitCommand=function(s) s:x(m("RingPNXOffset",pn)):y(m "RingYOffset") end}
	gradeFrame[#gradeFrame+1] = LoadActor("grade", pss)..{OnCommand= m"GradeOnCommand",OffCommand=m"GradeOffCommand"}
	if pss:FullCombo() then
		gradeFrame[#gradeFrame+1] = LoadActor("FullCombo 1x2")
	end
	t[#t+1] = gradeFrame

	--score frame
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

	local playerZone=Def.ActorFrame{InitCommand=function(s) s:x((pn=='PlayerNumber_P1' and -1 or 1)*m "PlayerXOffset") end}
	playerZone[#playerZone+1] = LoadActor("badge "..ToEnumShortString(pn))..{InitCommand=function(s) s:y(-metrics.QTOP+m "BadgeYOffset") end}
	if pss:GetMachineHighScoreIndex() == 0 then
		playerZone[#playerZone+1] = LoadActor(THEME:GetPathG("Machine","Record2"))..{InitCommand=function(s) s:y(-metrics.QBOTTOM-24) end}
	end
	if pss:GetPersonalHighScoreIndex() == 0 then
		playerZone[#playerZone+1] = LoadActor(THEME:GetPathG("Machine","Record1"))..{InitCommand=function(s) s:y(-metrics.QBOTTOM-16) end}
	end
	centerFrame[#centerFrame+1]=playerZone
end

return t;
local LoadingScreen = Var "LoadingScreen"
local t = Def.ActorFrame{}

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
--how thick the separator is
metrics.SEPARATOR_WIDTH = 1
metrics.NUM_OFFSET = m "NumberXOffset"

--a bunch of things that should all be center-aligned more or less
local judgmentFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "JudgmentFrameX"):y(m "JudgmentFrameY") end}
local labelPath = THEME:GetPathG("ScreenEvaluationNew", "rowlabels")

--the background
judgmentFrame[#judgmentFrame+1] = LoadActor("shape", metrics);

--the actual judgment rows
for index, name in pairs(RowsToShow) do
	--row label
	local baseY = metrics.BOTTOM+(metrics.ITEM_HEIGHT/2+(metrics.ITEM_HEIGHT+metrics.PADDING)*(index-1))
	judgmentFrame[#judgmentFrame+1] = Def.Sprite{
		Texture=labelPath,
		InitCommand=function(s)
			s:y(baseY):SetAllStateDelays(math.huge):setstate(m("Row"..name.."Frame"))
		end,
	}

	--row counter
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		judgmentFrame[#judgmentFrame+1] = Def.RollingNumbers{
			Font="ScreenEvaluationNew rownumber",
			InitCommand= function(s) s:Load(m "RollingNumbersClass"):y(baseY)
				:x((pn=='PlayerNumber_P1' and -1 or 1)*metrics.NUM_OFFSET)
				:targetnumber((m("Row"..name.."Value"))(PSSes[pn],pn))
			end
		}
	end

	--separator
	if index~=count then
		judgmentFrame[#judgmentFrame+1] = Def.Quad{
			InitCommand=function(s)
				s:y(baseY+metrics.ITEM_HEIGHT/2+metrics.PADDING/2):zoomy(metrics.SEPARATOR_WIDTH):zoomx(metrics.CORE)
				:diffuse{0,0,0,1}
			end,
		}
	end
end
t[#t+1] = judgmentFrame

for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	local pss = PSSes[pn]
	local gradeFrame = Def.ActorFrame{InitCommand=function(s) s:x(m "GradeXOffset"*(pn=='PlayerNumber_P1' and -1 or 1)+SCREEN_CENTER_X)
		:y(THEME:GetMetric(LoadingScreen,"GradeY")) end}
	gradeFrame[#gradeFrame+1] = LoadActor("fc_ring",pss)..{InitCommand=function(s) s:x(m("RingPNXOffset",pn)):y(m "RingYOffset") end}
	gradeFrame[#gradeFrame+1] = LoadActor("grade", pss, m"GradeOnCommand",m"GradeOffCommand")
	if pss:FullCombo() then
		gradeFrame[#gradeFrame+1] = LoadActor("FullCombo 1x2")
	end
	t[#t+1] = gradeFrame
end

return t;
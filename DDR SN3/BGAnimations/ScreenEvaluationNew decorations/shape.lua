local args = {...}
local count = args[1] --must be odd
local metrics = {}
metrics.ITEM_HEIGHT = 16
metrics.PADDING = 8
metrics.WIDTH = 854
metrics.RIGHT = metrics.WIDTH/2
metrics.LEFT = -metrics.RIGHT
metrics.HEIGHT = (metrics.ITEM_HEIGHT+metrics.PADDING)*count-(metrics.PADDING*2)
metrics.TOP = metrics.HEIGHT/2
metrics.BOTTOM = -metrics.TOP
metrics.QTOP = metrics.TOP - metrics.ITEM_HEIGHT
metrics.QBOTTOM = metrics.BOTTOM + metrics.ITEM_HEIGHT
metrics.TLEFT = 261+metrics.LEFT
metrics.TRIGHT = 595+metrics.LEFT
metrics.CORE = metrics.TRIGHT-metrics.TLEFT
metrics.TAB_WIDTH = metrics.ITEM_HEIGHT
metrics.TAB_LEFT = metrics.TLEFT + metrics.TAB_WIDTH
metrics.TAB_RIGHT = metrics.TRIGHT - metrics.TAB_WIDTH
local black = {0,0,0,1}
local vertices = {
	--first triangle: left half of rect
	{{metrics.RIGHT,metrics.QBOTTOM,0}, black},
	{{metrics.RIGHT,metrics.QTOP,0}, black},
	{{metrics.LEFT,metrics.QBOTTOM,0}, black},
	--second triangle: right half of rect
	{{metrics.RIGHT,metrics.QTOP,0}, black},
	{{metrics.LEFT,metrics.QTOP,0},black},
	{{metrics.LEFT,metrics.QBOTTOM,0},black},
	--third triangle: left half of top trapezoid
	{{metrics.TLEFT,metrics.QTOP,0}, black},
	{{metrics.TAB_LEFT, metrics.TOP, 0}, black},
	{{metrics.TAB_RIGHT, metrics.TOP,0}, black},
	--fourth triangle: right half of top trapezoid
	{{metrics.TAB_RIGHT,metrics.TOP,0}, black},
	{{metrics.TRIGHT, metrics.QTOP, 0}, black},
	{{metrics.TLEFT, metrics.QTOP, 0}, black},
	--fifth triangle: blah blah
	{{metrics.TLEFT,metrics.QBOTTOM,0}, black},
	{{metrics.TAB_LEFT, metrics.BOTTOM, 0}, black},
	{{metrics.TAB_RIGHT, metrics.BOTTOM,0}, black},
	--sixth triangle something
	{{metrics.TAB_RIGHT,metrics.BOTTOM,0}, black},
	{{metrics.TRIGHT, metrics.QBOTTOM, 0}, black},
	{{metrics.TLEFT, metrics.QBOTTOM, 0}, black}	
}

local quadColor = color"#00EC38"

return Def.ActorFrame{
	InitCommand=function(s) s:Center() end,
	Def.ActorMultiVertex{
		InitCommand=function(s) s:SetVertices(vertices):SetDrawState{Mode='DrawMode_Triangles'}:clearzbuffer(true):zwrite(true) end
	},
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(1)
			:diffuseleftedge(black):diffuserightedge(quadColor):ztest(true)
		end
	},
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(0)
			:diffuseleftedge(quadColor):diffuserightedge(black):ztest(true)
		end
	}
}
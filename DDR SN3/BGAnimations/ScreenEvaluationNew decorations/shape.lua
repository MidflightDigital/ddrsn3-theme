local args = {...}
local metrics = args[1]
--the absolute right side of the shape
metrics.RIGHT = metrics.WIDTH/2
--the absolute left side of the shape
metrics.LEFT = -metrics.RIGHT
--the top of the central rectangle of the shape
metrics.QTOP = metrics.TOP - metrics.ITEM_HEIGHT
--the bottom of the central rectangle of the shape
metrics.QBOTTOM = metrics.BOTTOM + metrics.ITEM_HEIGHT
--the height of the central rectangle of the shape
metrics.QHEIGHT = metrics.QTOP - metrics.QBOTTOM
--the width of the ears of the tabs
metrics.TAB_WIDTH = metrics.ITEM_HEIGHT
--the left edge of the top/bottom of the tabs
metrics.TAB_LEFT = metrics.TLEFT + metrics.TAB_WIDTH
--the right edge of the top/bottom of the tabs
metrics.TAB_RIGHT = metrics.TRIGHT - metrics.TAB_WIDTH

local black = {0,0,0,1}
local maskVertices = {
	--top left corner
	{{metrics.TLEFT, metrics.QTOP, 0}, black},
	{{metrics.TLEFT, metrics.TOP, 0}, black},
	{{metrics.TAB_LEFT, metrics.TOP, 0}, black},
	--top right corner
	{{metrics.TRIGHT, metrics.QTOP, 0}, black},
	{{metrics.TRIGHT, metrics.TOP, 0}, black},
	{{metrics.TAB_RIGHT, metrics.TOP, 0}, black},
	--bottom left corner
	{{metrics.TLEFT, metrics.QBOTTOM, 0}, black},
	{{metrics.TLEFT, metrics.BOTTOM, 0}, black},
	{{metrics.TAB_LEFT, metrics.BOTTOM, 0}, black},
	--bottom right corner
	{{metrics.TRIGHT, metrics.QBOTTOM, 0}, black},
	{{metrics.TRIGHT, metrics.BOTTOM, 0}, black},
	{{metrics.TAB_RIGHT, metrics.BOTTOM, 0}, black}
}

local quadColor = color"#00EC38"

return Def.ActorFrame{
	--the base rectangle
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.WIDTH):zoomy(metrics.QHEIGHT):diffuse(black) end
	},
	--the shaping mask
	Def.ActorMultiVertex{
		InitCommand=function(s) s:SetVertices(maskVertices):SetDrawState{Mode='DrawMode_Triangles'}:MaskSource() end
	},
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(1)
			:diffuseleftedge(black):diffuserightedge(quadColor):MaskDest()
		end
	},
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(0)
			:diffuseleftedge(quadColor):diffuserightedge(black):MaskDest()
		end
	}
}
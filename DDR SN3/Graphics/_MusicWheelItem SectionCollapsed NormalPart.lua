local group;



local t = Def.ActorFrame{
	LoadActor("_section inner")..{
		SetMessageCommand=function(self,params)
			group = params.Text;
		local so = GAMESTATE:GetSortOrder();
			if group then
				if so =="SortOrder_Title" then
					if group=='A' then
						self:diffuse(Color("Red"))
					elseif group=='B' then
						self:diffuse(Color("Green"))
					elseif group=='C' then
						self:diffuse(color("#00ff66"))
					elseif group=='D' then
						self:diffuse(Color("Blue"))
					elseif group=='E' then
						self:diffuse(Color("Blue"))
					elseif group=='F' then
						self:diffuse(Color("Pink"))
					elseif group=='G' then
						self:diffuse(Color("Red"))
					elseif group=='H' then
						self:diffuse(Color("Green"))
					elseif group=='I' then
						self:diffuse(Color("Red"))
					elseif group=='J' then
						self:diffuse(Color("Green"))
					elseif group=='K' then
						self:diffuse(Color("Blue"))
					elseif group=='L' then
						self:diffuse(Color("Blue"))
					elseif group=='M' then
						self:diffuse(Color("Pink"))
					elseif group=='N' then
						self:diffuse(Color("Red"))
					elseif group=='O' then
						self:diffuse(Color("Green"))
					elseif group=='P' then
					self:diffuse(Color("Green"))
					elseif group=='Q' then
						self:diffuse(Color("#00ff66"))
					elseif group=='R' then
						self:diffuse(Color("Blue"))
					elseif group=='S' then
					self:diffuse(Color("Blue"))
					elseif group=='T' then
						self:diffuse(Color("Pink"))
					elseif group=='U' then
						self:diffuse(Color("Red"))
					elseif group=='V' then
						self:diffuse(Color("Green"))
					elseif group=='W' then
						self:diffuse(Color("Green"))
					elseif group=='X' then
						self:diffuse(Color("Red"))
					elseif group=='Y' then
						self:diffuse(Color("Blue"))
					elseif group=='Z' then
						self:diffuse(Color("Blue"))
					end;
				elseif so == "SortOrder_Group" then
					if group=='1-Licenses' then
						self:diffuse(color("#FFFFFF"))
					elseif group=='2-KONAMI ORIGINALS' then
						self:diffuse(color("#00CC00"))
					elseif group=='3-Requests' then
						self:diffuse(color("#FFFF00"))
					elseif group=='4-Revivals' then
						self:diffuse(color("#33CCFF"))
					elseif group=='5-NOVAmix' then
						self:diffuse(color("#FF00FF"))
					elseif group=='6a-ENCORE EXTRA STAGE' then
						self:diffuse(Color("White"))
					elseif group=='6b-EXTRA STAGE' then
						self:diffuse(Color("Red"))
					elseif group=='7-DLC' then
						self:diffuse(Color("Yellow"))
					end;
				else
					self:diffuse(Color("White"))
				end;
			end;
		end;
	};
};

return t;
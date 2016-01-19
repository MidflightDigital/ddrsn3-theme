--settings_system from Consensual by Kyzentun.
--github.com/kyzentun/consensual
local settings_prefix= "/MidflightDigital/"
global_cur_game= GAMESTATE:GetCurrentGame():GetName():lower()

function get_element_by_path(container, path)
	local parts= split_name(path)
	local current= container
	for i= 1, #parts do
		current= current[parts[i]]
		if not current then return end
	end
	return current
end

function set_element_by_path(container, path, value)
	local parts= split_name(path)
	local current= container
	for i= 1, #parts-1 do
		current= current[parts[i]]
		if not current then return end
	end
	current[parts[#parts]]= value
end

function string_in_table(str, tab)
	if not str or not tab then return false end
	for i, s in ipairs(tab) do
		if s == str then return i end
	end
	return false
end

function table_find_remove(tab, thing)
	local index= string_in_table(thing, tab)
	if index then table.remove(tab, index) end
end

function force_table_elements_to_match_type(candidate, must_match, depth_remaining, exceptions)
	for k, v in pairs(candidate) do
		if not string_in_table(k, exceptions) then
			if type(must_match[k]) ~= type(v) then
				candidate[k]= nil
			elseif type(v) == "table" and depth_remaining ~= 0 then
				force_table_elements_to_match_type(v, must_match[k], depth_remaining-1, exceptions)
			end
		end
	end
	for k, v in pairs(must_match) do
		if type(candidate[k]) == "nil" then
			if type(v) == "table" then
				candidate[k]= DeepCopy(v)
			else
				candidate[k]= v
			end
		end
	end
end

local function id_to_prof_dir(id, reason)
	local prof_dir= nil
	if id == "!MACHINE" then
		prof_dir= "Save"
	elseif id:match("^!MC[01]$") then
		local player= (id=="!MC0") and 'PlayerNumber_P1' or 'PlayerNumber_P2'
		if not PROFILEMAN:ProfileWasLoadedFromMemoryCard(player) then
			return
		end
		local slot= ({['PlayerNumber_P1']='ProfileSlot_Player1',['PlayerNumber_P2']='ProfileSlot_Player2'})[player]
		if slot then
			prof_dir= PROFILEMAN:GetProfileDir(slot)
		end
	elseif id and id~="" then
		prof_dir= PROFILEMAN:LocalProfileIDToDir(id)
	end
	return (prof_dir~="") and prof_dir or nil
end

function load_conf_file(fname)
	local file= RageFileUtil.CreateRageFile()
	local ret= {}
	if file:Open(fname, 1) then
		local data= loadstring(file:Read())
		setfenv(data, {})
		local success, data_ret= pcall(data)
		if success then
			ret= data_ret
		end
		file:Close()
	end
	file:destroy()
	return ret
end

local setting_mt= {
	__index= {
		init= function(self, name, file, default, match_depth, exceptions, use_global_as_default)
			assert(type(default) == "table", "default for setting must be a table.")
			self.name= name
			self.file= file
			self.default= default
			self.match_depth= match_depth
			self.dirty_table= {}
			self.data_set= {}
			self.exceptions= exceptions
			self.use_global_as_default= use_global_as_default
			return self
		end,
		apply_force= function(self, cand, id)
			if self.match_depth and self.match_depth ~= 0 then
				force_table_elements_to_match_type(
					cand, self:get_default(id), self.match_depth-1, self.exceptions)
			end
		end,
		get_default= function(self, id)
			if not self.use_global_as_default or not id or id == "" then
				return self.default
			end
			if not self.data_set[""] then
				self:load()
			end
			return self.data_set[""]
		end,
		load= function(self, id)
			id= id or ""
			local prof_dir= id_to_prof_dir(id, "read " .. self.name)
			if not prof_dir then
				self.data_set[id]= DeepCopy(self:get_default(id))
			else
				local fname= self:get_filename(id)
				if not FILEMAN:DoesFileExist(fname) then
					self.data_set[id]= DeepCopy(self:get_default(id))
				else
					local from_file= load_conf_file(fname)
					if type(from_file) == "table" then
						self:apply_force(from_file, id)
						self.data_set[id]= from_file
					else
						self.data_set[id]= DeepCopy(self:get_default(id))
					end
				end
			end
			return self.data_set[id]
		end,
		get_data= function(self, id)
			id= id or ""
			return self.data_set[id] or self.default
		end,
		set_data= function(self, id, data)
			id= id or ""
			self.data_set[id]= data
		end,
		set_dirty= function(self, id)
			id= slot or ""
			self.dirty_table[id]= true
		end,
		check_dirty= function(self, id)
			id= id or ""
			return self.dirty_table[id]
		end,
		clear_slot= function(self, id)
			id= id or ""
			self.dirty_table[id]= nil
			self.data_set[id]= nil
		end,
		get_filename= function(self, id)
			id= id or ""
			local prof_dir= id_to_prof_dir(is, "write " .. self.name)
			if not prof_dir then return end
			return prof_dir .. settings_prefix .. self.file
		end,
		save= function(self, id)
			id= id or ""
			if not self:check_dirty(id) then return end
			local fname= self:get_filename(id)
			local file_handle= RageFileUtil.CreateRageFile()
			if not file_handle:Open(fname, 2) then
				Warn("Could not open '" .. fname .. "' to write " .. self.name .. ".")
			else
				local output= "return " .. lua_table_to_string(self.data_set[id])
				file_handle:Write(output)
				file_handle:Close()
				file_handle:destroy()
			end
		end,
		save_all= function(self)
			for id, data in pairs(self.data_set) do
				self:save(id)
			end
		end
}}

function create_setting(name, file, default, match_depth, exceptions, use_global_as_default)
	return setmetatable({}, setting_mt):init(name, file, default, match_depth, exceptions, use_global_as_default)
end

function write_str_to_file(str, fname, str_name)
	local file_handle= RageFileUtil.CreateRageFile()
	if not file_handle:Open(fname, 2) then
		Warn("Could not open '" .. fname .. "' to write " .. str_name .. ".")
	else
		file_handle:Write(str)
		file_handle:Close()
		file_handle:destroy()
	end
end

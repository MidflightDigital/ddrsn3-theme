--It turns out that past tertu fucked this function up.
--A fix will probably hit 5.1 but for now we're going to do this.
function ThemeManager:GetAbsolutePath(sPath)
	sFinPath = "/Themes/"..self:GetCurThemeName().."/"..sPath
	assert(FILEMAN:DoesFileExist(sFinPath), "the theme element "..sPath.." is missing")
	return sFinPath
end

--the version of getenv/setenv exported by fallback is not actually the same as
--operations on the Env() table. however, it is advertised as being the same.
--these overrides make it actually the same.
function getenv(name)
	local env = GAMESTATE:Env()
	return env[name]
end

function setenv(name, value)
	local env = GAMESTATE:Env()
	env[name] = value
end
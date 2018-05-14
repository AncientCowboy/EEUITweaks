Infinity_RegisterFile("en_ModOp.lua")
if(uiTranslationFile) then
	Infinity_RegisterFile(string.sub(uiTranslationFile,1,3).."ModOp.lua")
end

local enabledButtons
enabledButtons = {
	{text = "CREDITS_BUTTON",  menu = "CREDITS",          sequence = 0},
	{text = "GAMEPLAY_BUTTON", menu = "OPTIONS_GAMEPLAY", sequence = 0},
	{text = "GRAPHICS_BUTTON", menu = "OPTIONS_GRAPHICS", sequence = 1},
	{text = "LANGUAGE_BUTTON", menu = "OPTIONS_LANGUAGE", sequence = 0},
	{text = "MODOPT_BUTTON",   menu = "OPTIONS_MODS",     sequence = 0},
	{text = "MOVIES_BUTTON",   menu = "",                 sequence = 2},
	{text = "SOUND_BUTTON",    menu = "OPTIONS_SOUND",    sequence = 1},
}
local disabledButtons
disabledButtons = {
	{text = "CREDITS_BUTTON",  menu = "CREDITS",          sequence = 0},
	{text = "GAMEPLAY_BUTTON", menu = "OPTIONS_GAMEPLAY", sequence = 0},
	{text = "GRAPHICS_BUTTON", menu = "OPTIONS_GRAPHICS", sequence = 1},
	{text = "LANGUAGE_BUTTON", menu = "OPTIONS_LANGUAGE", sequence = 0},
	{text = "MOVIES_BUTTON",   menu = "",                 sequence = 2},
	{text = "SOUND_BUTTON",    menu = "OPTIONS_SOUND",    sequence = 1},
}

local localRegistrations = {}
modOptionsRegistrations = {}
modOptionsIdx = 0
modOptionsInfo = ""

function modOptionsRegisterMenu(modname, menuname, description, menuflag)
	assert(type(modname) == 'string', "modname argument to modOptionsRegisterMenu not a string")
	if not(uiStrings[modname]) then uiStrings[modname] = modname end

	assert(type(menuname) == 'string', "menuname argument to modOptionsRegisterMenu not a string")

	if((description == nil) or (description == "")) then
		description = "MODOPT_EMPTY"
	else
		assert(type(description) == 'string', "description argument to modOptionsRegisterMenu not a string")
		if not(uiStrings[description]) then uiStrings[description] = description end
	end

	-- 0 => both, 1 => start only, 2 => in-game only. Any other (or none, or invalid) => 0
	menuflag = menuflag or 0
	menuflag = not(tonumber(menuflag)) and 0 or ((tonumber(menuflag) < 0 or tonumber(menuflag) > 2) and 0 or tonumber(menuflag))

	local targetidx = #localRegistrations+1
	for i, v in ipairs(localRegistrations) do
		if(v.name == modname) then
			targetidx = i
		end
	end
	localRegistrations[targetidx] = {name = modname, description = description, menuid = menuname, menuflag = menuflag}
	table.sort(localRegistrations, function(a,b) return uiStrings[a.name] < uiStrings[b.name] end)
end

function modOptionsValidSelection()
	return ((modOptionsRegistrations[modOptionsIdx] ~= nil) and
	        (modOptionsRegistrations[modOptionsIdx].menuid ~= nil))
end

function modOptionsFilterRegistrations()
	modOptionsRegistrations = {}
	local ingame = Infinity_IsMenuOnStack('ESC_MENU')

	for idx, v in ipairs(localRegistrations) do
		if (ingame and (v.menuflag % 2) == 0) or (not(ingame) and (v.menuflag < 2)) then
			table.insert(modOptionsRegistrations, v)
		end
	end
end

function modOptionsIngameEnabled()
	local rval = Infinity_GetINIValue(modOptionsToggles[1][5], modOptionsToggles[1][6])
	return (rval and rval == 1) and 0 or 1
end

function modOptionsIngameDisabled()
	local rval = Infinity_GetINIValue(modOptionsToggles[1][5], modOptionsToggles[1][6])
	return (rval and rval == 1) and 1 or 0
end

function modOptionsStartupEnabled()
	local rval = Infinity_GetINIValue(modOptionsToggles[2][5], modOptionsToggles[2][6])
	return (rval and rval == 1) and 0 or 1
end

function modOptionsStartupDisabled()
	local rval = Infinity_GetINIValue(modOptionsToggles[2][5], modOptionsToggles[2][6])
	return (rval and rval == 1) and 1 or 0
end

function modOptionsStartMenu()
	if(modOptionsStartupEnabled() == 0) then
		OptionsButtons = disabledButtons
		Infinity_SetArea('OPTIONS_LIST', nil, 240, nil, 332)
	else
		OptionsButtons = enabledButtons
		Infinity_SetArea('OPTIONS_LIST', nil, 187, nil, 385)
	end
end

local bg2logoframe = 0
function modOptionsRememberLogo(framenumber)
	bg2logoframe = framenumber
end

function modOptionsRecallLogo()
	return bg2logoframe
end

-- Mods Options Options support
-- Label Key, Description Key, toggle frame, toggle value, INI section name, INI option key
modOptionsToggles = {
	{"MODOPT_INGAME_LABEL",		"MODOPT_INGAME_INFO",	0,	0,	"Mod Options",	"Disable Ingame Menu"},
	{"MODOPT_STARTUP_LABEL",	"MODOPT_STARTUP_INFO",	0,	0,	"Mod Options",	"Disable Start Menu"},
}

modOptionsOpIdx = 0
modOptionsOpInfo = ""

function modOptionGetToggleOption(idx)
	return Infinity_GetINIValue(modOptionsToggles[idx][5], modOptionsToggles[idx][6])
end

function modOptionSetToggleOption(idx)
	Infinity_SetINIValue(modOptionsToggles[idx][5], modOptionsToggles[idx][6], modOptionsToggles[idx][4])
end

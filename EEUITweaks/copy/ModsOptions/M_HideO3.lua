-- Label Key, Description Key, toggle frame, toggle value, INI section name, INI option key  
hiddenOptionsToggles = {
	{"HIDEOPT_UI_EDIT_LABEL",		"HIDEOPT_UI_EDIT_DESCRIPTION",		0,	0,	"Program Options",	"UI Edit Mode"},
	{"HIDEOPT_DEBUG_MODE_LABEL",	"HIDEOPT_DEBUG_MODE_DESCRIPTION",	0,	0,	"Program Options",	"Debug Mode"},
	{"HIDEOPT_EXTRACOMBAT_LABEL",	"HIDEOPT_EXTRACOMBAT_DESCRIPTION", 	0,	0,	"Game Options",		"Extra Combat Info"},
	{"HIDEOPT_FOG_LABEL",			"HIDEOPT_FOG_DESCRIPTION", 			0,	0,	"Game Options",		"Enable Fog"},
	{"HIDEOPT_PAUSEDATE_LABEL",		"HIDEOPT_PAUSEDATE_DESCRIPTION", 	0,	0,	"Game Options",		"Show Date On Pause"},
	{"HIDEOPT_DISABLE_MAPZ_LABEL",	"HIDEOPT_DISABLE_MAPZ_DESCRIPTION",	0,	0,	"Graphics",			"Disable Area Map Zoom"}, 
	{"HIDEOPT_SHOWTRIGTAB_LABEL",	"HIDEOPT_SHOWTRIGTAB_DESCRIPTION", 	0,	0,	"Game Options",		"Show Triggers On Tab"},
	{"HIDEOPT_CHEATS_LABEL",		"HIDEOPT_CHEATS_DESCRIPTION", 		0,	0,	"Game Options",		"Cheats"},
	{"HIDEOPT_NOMOVIES_LABEL",		"HIDEOPT_NOMOVIES_DESCRIPTION", 	0,	0,	"Program Options",	"Disable Movies"},
	{"HIDEOPT_REVERSE_MOUSE_LABEL",	"HIDEOPT_REVERSE_MOUSE_DESCRIPTION",0,	0,	"Game Options",		"Reverse Mouse Wheel Zoom"},
	{"HIDEOPT_STRREF_LABEL",		"HIDEOPT_STRREF_DESCRIPTION", 		0,	0,	"Program Options",	"Strref On"},
	{"HIDEOPT_CHSS_LABEL",			"HIDEOPT_CHSS_DESCRIPTION", 		0,	0,	"Game Options",		"Critical Hit Screen Shake"},
	{"HIDEOPT_HPOH_LABEL",			"HIDEOPT_HPOH_DESCRIPTION", 		0,	0,	"Game Options",		"HP Over Head"},
	{"HIDEOPT_NDBXP_LABEL",			"HIDEOPT_NDBXP_DESCRIPTION", 		0,	0,	"Game Options",		"No Difficulty Based XP Bonus"},
	{"HIDEOPT_NBXP_LABEL",			"HIDEOPT_NBXP_DESCRIPTION", 		0,	0,	"Game Options",		"Nightmare Bonus XP"},
	{"HIDEOPT_NBGLD_LABEL",			"HIDEOPT_NBGLD_DESCRIPTION", 		0,	0,	"Game Options",		"Nightmare Bonus Gold"},
	{"HIDEOPT_EXFB_LABEL",			"HIDEOPT_EXFB_DESCRIPTION", 		0,	0,	"Game Options",		"Extra Feedback"},
	{"HIDEOPT_SLSP_LABEL",			"HIDEOPT_SLSP_DESCRIPTION", 		0,	0,	"Game Options",		"Show Learnable Spells"},
	{"HIDEOPT_HKOTT_LABEL",			"HIDEOPT_HKOTT_DESCRIPTION", 		0,	0,	"Game Options",		"Hotkeys On Tooltips"},
	{"HIDEOPT_DUPFT_LABEL",			"HIDEOPT_DUPFT_DESCRIPTION", 		0,	0,	"Game Options",		"Duplicate Floating Text"},
	{"HIDEOPT_PMAP_LABEL",			"HIDEOPT_PMAP_DESCRIPTION", 		0,	0,	"Game Options",		"Pausing Map"},
	{"HIDEOPT_ALSINFO_LABEL",		"HIDEOPT_ALSINFO_DESCRIPTION", 		0,	0,	"Game Options",		"All Learn Spell Info"},
	{"HIDEOPT_3ETHIEF_LABEL",		"HIDEOPT_3ETHIEF_DESCRIPTION", 		0,	0,	"Game Options",		"3E Thief Sneak Attack"},
}

--    Label Key, 				Description Key, 				 #Values, Base value, multiplier, slider value,   INI section name, 	INI option key
hiddenOptionsSliders = {
	{"HIDEOPT_BORE_LABEL",		"HIDEOPT_BORE_DESCRIPTION",			65,		1,		1000,			0,			"Game Options",		"Bored Timeout"},
	{"HIDEOPT_TPRECACHE_LABEL",	"HIDEOPT_TPRECACHE_DESCRIPTION",	101,	0,		   1,			0,			"Game Options",		"Tiles Precache Percent"},
}

currentHiddenIdx = 0
currentHiddenSL = 0
currentHiddenInfo = ""
deferredOptions = {}

function getDeferredOption(section, option)
	if (not deferredOptions[tostring(section)]) then
		deferredOptions[tostring(section)] = {}
	end
	if (not deferredOptions[section][tostring(option)]) then
		deferredOptions[section][tostring(option)] = tonumber(Infinity_GetINIValue(section,option)) or 0
	end
	return deferredOptions[section][option]
end

function setDeferredOption(section, option, value)
	if (not deferredOptions[tostring(section)]) then
		deferredOptions[tostring(section)] = {}
	end
	deferredOptions[section][tostring(option)] = tonumber(value) or 0
end

function flushDeferredOptions()
	for s,t in pairs(deferredOptions) do
		for o,v in pairs(t) do
			Infinity_SetINIValue(s,o,v)
		end
	end
end

function hiddenGetToggleOption(idx)
	return getDeferredOption(hiddenOptionsToggles[idx][5], hiddenOptionsToggles[idx][6])
end

function hiddenSaveToggleOption(idx)
	setDeferredOption(hiddenOptionsToggles[idx][5], hiddenOptionsToggles[idx][6], hiddenOptionsToggles[idx][4])
end

function hiddenGetSliderValue(idx)
	return (hiddenOptionsSliders[idx][4] + hiddenOptionsSliders[idx][6]) * hiddenOptionsSliders[idx][5]
end

function hiddenGetSliderOption(idx)
	local val = getDeferredOption(hiddenOptionsSliders[idx][7], hiddenOptionsSliders[idx][8]) or 0
	local minval = (hiddenOptionsSliders[idx][4]) * hiddenOptionsSliders[idx][5]
	local maxval = (hiddenOptionsSliders[idx][4] + hiddenOptionsSliders[idx][3] - 1) * hiddenOptionsSliders[idx][5]
	val = ((val < minval) and minval) or (((val > maxval) and maxval) or val)
	return math.floor(val/hiddenOptionsSliders[idx][5]+0.5)-hiddenOptionsSliders[idx][4]
end

function hiddenSaveSliderOption(idx)
	setDeferredOption(hiddenOptionsSliders[idx][7], hiddenOptionsSliders[idx][8], tostring(hiddenGetSliderValue(idx)))
end
	


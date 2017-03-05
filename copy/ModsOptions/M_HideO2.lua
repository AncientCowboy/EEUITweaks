
if(uiTranslationFile) then
	Infinity_DoFile("L_" .. uiTranslationFile)
	Infinity_DoFile(string.sub(uiTranslationFile,1,3).."HideO.lua")
	if(uiStrings.HIDEOPT_TITLE == nil) then -- Badly named or non-existant file
		Infinity_DoFile("en_HideO.lua")
	end
else
	Infinity_DoFile("L_en_us")
	Infinity_DoFile("en_HideO.lua")
end

-- Label Key, Description Key, toggle frame, toggle value, INI section name, INI option key  
hiddenOptionsToggles = {
	{"HIDEOPT_UI_EDIT_LABEL",		"HIDEOPT_UI_EDIT_DESCRIPTION",		0,	0,	"Program Options",	"UI Edit Mode"},
	{"HIDEOPT_DEBUG_MODE_LABEL",	"HIDEOPT_DEBUG_MODE_DESCRIPTION",	0,	0,	"Program Options",	"Debug Mode"},
}

-- Label Key, Description Key, #Values, Base value, multiplier, slider value, INI section name, INI option key
hiddenOptionsSliders = {
	{"HIDEOPT_MAX_FRAME_RATE_LABEL",	"HIDEOPT_MAX_FRAME_RATE_DESCRIPTION",	31,	30,	1,		0,	"Program Options",	"Max Frame Rate"},
}

currentHiddenIdx = 0
currentHiddenSL = 0
currentHiddenInfo = ""

function hiddenGetToggleOption(idx)
	return Infinity_GetINIValue(hiddenOptionsToggles[idx][5], hiddenOptionsToggles[idx][6])
end

function hiddenSaveToggleOption(idx)
	Infinity_SetINIValue(hiddenOptionsToggles[idx][5], hiddenOptionsToggles[idx][6], hiddenOptionsToggles[idx][4])
end

function hiddenGetSliderValue(idx)
	return (hiddenOptionsSliders[idx][4] + hiddenOptionsSliders[idx][6]) * hiddenOptionsSliders[idx][5]
end

function hiddenGetSliderOption(idx)
	local val = Infinity_GetINIValue(hiddenOptionsSliders[idx][7], hiddenOptionsSliders[idx][8]) or 0
	local minval = (hiddenOptionsSliders[idx][4]) * hiddenOptionsSliders[idx][5]
	local maxval = (hiddenOptionsSliders[idx][4] + hiddenOptionsSliders[idx][3] - 1) * hiddenOptionsSliders[idx][5]
	val = ((val < minval) and minval) or (((val > maxval) and maxval) or val)
	return math.floor(val/hiddenOptionsSliders[idx][5]+0.5)-hiddenOptionsSliders[idx][4]
end

function hiddenSaveSliderOption(idx)
	Infinity_SetINIValue(hiddenOptionsSliders[idx][7], hiddenOptionsSliders[idx][8], tostring(hiddenGetSliderValue(idx)))
end
	


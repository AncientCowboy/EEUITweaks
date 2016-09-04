local hiddenOptionsStrings 
hiddenOptionsStrings = {
	HIDEOPT_TITLE = "Hidden Game",
	HIDEOPT_INFO = "Enables/disables several Baldur.lua options not accessable via current options panels.",
	HIDEOPT_UI_EDIT_LABEL = "UI Edit Mode",
	HIDEOPT_UI_EDIT_DESCRIPTION = "Enable/disable the F11/F5 interactive UI editing feature.\nGame restart needed to take effect.",
	HIDEOPT_DEBUG_MODE_LABEL = "Debug Mode",
	HIDEOPT_DEBUG_MODE_DESCRIPTION = "Enable/disable debug mode. Currently also enables cheats.\nGame restart needed to take effect.",
	HIDEOPT_CHEATS_LABEL = "Cheats",
	HIDEOPT_CHEATS_DESCRIPTION = "Enable/disable cheat mode. Largely defunct but still used by some mods.",
	HIDEOPT_MAX_FRAME_RATE_LABEL = "Maximum Frame Rate",
	HIDEOPT_MAX_FRAME_RATE_DESCRIPTION = "Sets game maximum frame rate. Above 40 can cause issues.\nGame restart needed to take effect.",
}

for k,v in pairs(hiddenOptionsStrings) do
	uiStrings[k]=v
end

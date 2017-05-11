local hiddenOptionsStrings 
hiddenOptionsStrings = {
-- Titles
	HIDEOPT_TITLE = "Hidden Game",
	HIDEOPT_INFO = "Enables/disables several Baldur.lua options not accessable via current options panels.",

-- Toggles
	HIDEOPT_UI_EDIT_LABEL = "UI Edit Mode",
	HIDEOPT_UI_EDIT_DESCRIPTION = "Enables/disables the F11/F5 interactive UI editing feature.\nGame restart needed to take effect.",

	HIDEOPT_DEBUG_MODE_LABEL = "Debug Mode",
	HIDEOPT_DEBUG_MODE_DESCRIPTION = "Enables/disables debug mode. Currently also enables cheats.\nGame restart needed to take effect.",

	HIDEOPT_EXTRACOMBAT_LABEL = "Extra Combat Information",
	HIDEOPT_EXTRACOMBAT_DESCRIPTION = "Enables/disables displaying extended combat information during battle.\nGame restart needed to take effect.",

	HIDEOPT_FOG_LABEL = "Show Fog",
	HIDEOPT_FOG_DESCRIPTION = "Enables/disables fog effect.\nGame restart needed to take effect.",

	HIDEOPT_PAUSEDATE_LABEL = "Show Date/Time On Pause",
	HIDEOPT_PAUSEDATE_DESCRIPTION = "Enables/disables displaying the date and time when the game is paused.\nGame restart needed to take effect",

	-- PSTEE Only
	HIDEOPT_DISABLE_MAPZ_LABEL = "Disable Area Map Zoom",
	HIDEOPT_DISABLE_MAPZ_DESCRIPTION = "When selected, disables the animation when area map is opened.\nGame restart needed to take effect.",

	HIDEOPT_SHOWTRIGTAB_LABEL = "Show Triggers On Tab",
	HIDEOPT_SHOWTRIGTAB_DESCRIPTION = "Enables/disables showing icons for exits, containers, etc. when Tab key pressed.\nGame restart needed to take effect.",

	HIDEOPT_WILDSRGKEY_LABEL = "Wild Surge Key",
	HIDEOPT_WILDSRGKEY_DESCRIPTION = "Enables/disables Ctrl-H wild surge selection.\nGame restart needed to take effect.",

	HIDEOPT_CHEATS_LABEL = "Cheats",
	HIDEOPT_CHEATS_DESCRIPTION = "Enables/disables cheat mode. Largely defunct but still used by some mods.\nGame restart needed to take effect.",

	HIDEOPT_NOMOVIES_LABEL = "Disable Movies",
	HIDEOPT_NOMOVIES_DESCRIPTION = "When selected, disables movie playback during game.\nGame restart needed to take effect.",

	HIDEOPT_REVERSE_MOUSE_LABEL = "Reverse Mouse Wheel Zoom",
	HIDEOPT_REVERSE_MOUSE_DESCRIPTION = "When selected, reverses the zoom direction performed by the mouse wheel.\nGame restart needed to take effect.",

	HIDEOPT_STRREF_LABEL = "Strref On",
	HIDEOPT_STRREF_DESCRIPTION = "When enabled, strings will be preceeded by their strref numbers.\nGame restart needed to take effect.",

	HIDEOPT_CHSS_LABEL = "Critical Hit Screen Shake",
	HIDEOPT_CHSS_DESCRIPTION = "Enables/disables screen shake effect on critical hits.\nGame restart needed to take effect.",

	HIDEOPT_HPOH_LABEL = "HP Over Head",
	HIDEOPT_HPOH_DESCRIPTION = "When selected, current/total hit points are displayed above each character's sprite.\nGame restart needed to take effect.",

	-- Not PSTEE 
	HIDEOPT_CRSPELL_LABEL = "Cleric Ranger Spells",
	HIDEOPT_CRSPELL_DESCRIPTION = "When selected, limits druidic spells for cleric/rangers to level 3.\nGame restart needed to take effect.",

	HIDEOPT_NDBXP_LABEL = "No Difficulty Based XP Bonus",
	HIDEOPT_NDBXP_DESCRIPTION = "When selected, disables bonus XP in Hard and Insane modes.\nGame restart needed to take effect.",

	HIDEOPT_NBXP_LABEL = "Nightmare Bonus XP",
	HIDEOPT_NBXP_DESCRIPTION = "Enables/disables bonus XP in nightmare mode.\nGame restart needed to take effect.",
	
	HIDEOPT_NBGLD_LABEL = "Nightmare Bonus Gold",
	HIDEOPT_NBGLD_DESCRIPTION = "Enables/disables bonus gold rewards in nightmare mode.\nGame restart needed to take effect.",

	HIDEOPT_EXFB_LABEL = "Extra Feedback",
	HIDEOPT_EXFB_DESCRIPTION = "When selected, displays detailed hit and damage roll calculations.\nGame restart needed to take effect.",

	HIDEOPT_SLSP_LABEL = "Show Learnable Spells",
	HIDEOPT_SLSP_DESCRIPTION = "Enables/disables green border on scrolls for learnable spells.\nGame restart needed to take effect.",

	HIDEOPT_HKOTT_LABEL = "Hotkeys On Tooltips",
	HIDEOPT_HKOTT_DESCRIPTION = "Enables/disables display of assigned hotkey on action bar tooltips.\nGame restart needed to take effect.",

	HIDEOPT_DUPFT_LABEL = "Duplicate Floating Text",
	HIDEOPT_DUPFT_DESCRIPTION = "When selected, causes gameworld floating text to be duplicated in message box.\nGame restart needed to take effect.",

	HIDEOPT_PMAP_LABEL = "Pausing Map",
	HIDEOPT_PMAP_DESCRIPTION = "When selected, the game will pause while viewing map.\nGame restart needed to take effect.",

	HIDEOPT_ALSINFO_LABEL = "All Learn Spell Info",
	HIDEOPT_ALSINFO_DESCRIPTION = "When selected, gives additional feedback on learn spell failure.\nGame restart needed to take effect.",

	HIDEOPT_3ETHIEF_LABEL = "3E Thief Sneak Attack",
	HIDEOPT_3ETHIEF_DESCRIPTION = "Enables/disables D&D version 3E rules for sneak attack.\nGame restart needed to take effect.",

-- Sliders
	HIDEOPT_BRIGHTNESS_LABEL = "Brightness Correction",
	HIDEOPT_BRIGHTNESS_DESCRIPTION = "Increases brightness of sprites when set above 0.\nGame restart needed to take effect.",

	HIDEOPT_BORE_LABEL = "Bored Timeout",
	HIDEOPT_BORE_DESCRIPTION = "Inactive time until PCs start complaining.\nGame restart needed to take effect",

	HIDEOPT_TPRECACHE_LABEL = "Tiles Precache Percent",
	HIDEOPT_TPRECACHE_DESCRIPTION = "Setting below 100 may decrease area load times but may also result in choppy scrolling.\nGame restart needed to take effect.",

	HIDEOPT_PATHNODES_LABEL = "Path Search Nodes",
	HIDEOPT_PATHNODES_DESCRIPTION = "Determines number of calculations done for pathfinding.\nGame restart needed to take effect.",

}

for k,v in pairs(hiddenOptionsStrings) do
	uiStrings[k]=v
end

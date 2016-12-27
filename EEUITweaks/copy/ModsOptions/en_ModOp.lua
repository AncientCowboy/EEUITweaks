
local modOptionStrings 
modOptionStrings = {
	MODOPT_TITLE = "Mods Options",
	MODOPT_BUTTON = "MODS OPTIONS",
	MODOPT_INFO = "Change settings affecting the behavior and/or appearance of the selected mod",
--	MODOPT_INFO = "Now is the time for all good men to come to the aid of now is the time for all bad men to come to the aid of now is the time for all gold men to come to the aid of now is the time for all red men to come to the aid of their country",
	MODOPT_CHANGE_BUTTON = "CHANGE",
-- Mods Options Settings support
	MODOPT_MODOPT_TITLE = "Mods Options Settings",
	MODOPT_MODOPT_INFO = "Allows enabling/disabling this feature for the in-game and/or game start environments",
	MODOPT_INGAME_LABEL = "Disable In-game Mods Options",
	MODOPT_INGAME_INFO = "When selected, disables the in-game Mods Options",
	MODOPT_STARTUP_LABEL = "Disable Game Start Mods Options",
	MODOPT_STARTUP_INFO = "When selected, disables the game start Mods Options",
-- Pecca's UI Settings support
	MODOPT_UISETTINGS_TITLE = "Dragonspear UI++",
	MODOPT_UISETTINGS_INFO = "Controls several user interface features provided by the Dragonspear UI++ package",
}

for k,v in pairs(modOptionStrings) do
	uiStrings[k]=v
end

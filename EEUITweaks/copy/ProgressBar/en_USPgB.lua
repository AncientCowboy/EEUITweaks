local pgBarStrings
pgBarStrings = {
	PGBAR_ENABLE_LABEL = "Enable in",
	PGBAR_ENABLED_LABEL = "Enabled",
	PGBAR_UNKNOWN_LABEL = "Unknown",
-- Progress bar options strings
	PROGBAROPT_TITLE = "Progress Bar Tweaks",
	PROGBAROPT_INFO = "Enables/disables features, and sets colors for the progress bar tweaks.",
	PROGBAROPT_DISABLE_MULTIPLIER_LABEL = "Disable Multiplier",
	PROGBAROPT_DISABLE_MULTIPLIER_DESCR = "When selected, disables multiplying the experience required times the number of classes for multi-class characters",
	PROGBAROPT_DISABLE_DELTAS_LABEL = "Disable XP Deltas",
	PROGBAROPT_DISABLE_DELTAS_DESCR = "When selected, disables displaying XP progress as being relative to the last class level up.\nMakes the xp progress relative to 0 (absolute)",
	PROGBAROPT_DISABLE_LEVELUP_LABEL = "Disable Level Up",
	PROGBAROPT_DISABLE_DEVELUP_DESCR = "When selected, disables a full progress bar invoking the Level Up screen when clicked.",
	PROGBAROPT_ENABLE_EMPTYDUAL_LABEL = "Enable Initial Empty",
	PROGBAROPT_ENABLE_EMPTYDUAL_DESCR = "When selected, dual class characters' initial class XP bar will be displayed as empty when the initial class is re-activated.",
	PROGBAROPT_GREY_SCALE_DUAL_LABEL = "Grey Scale Initial",
	PROGBAROPT_GREY_SCALE_DUAL_DESCR = "When selected, dual class characters' initial class progress bar will be painted using grey scale rather than the Filling/Full color scheme used for other progress bars.",
	PROGBAROPT_DISABLE_PORTRAIT_LABEL = "Disable Portrait Click",
	PROGBAROPT_DISABLE_PORTRAIT_DESCR = 'When selected, disables the "alternate portrait display on click" feature.',
	PROGBAROPT_DISABLE_COMBAT_LABEL = "Disable Combat Statistics",
	PROGBAROPT_DISABLE_COMBAT_DESCR = 'When selected, disables displaying combat statistics in the alternate portrait display feature.',
	PROGBAROPT_COLOR_LABEL = "Progress Bar Filling Color",
	PROGBAROPT_COLOR_DESCR = "Select the Red, Green, and Blue color components for progress bars that have not yet filled.",
	PROGBAROPT_FULL_LABEL = "Progress Bar Full Color",
	PROGBAROPT_FULL_DESCR = "Select the Red, Green, and Blue color components for progress bars that have been filled.",
	PROGBAROPT_INIT_PORT_LABEL = "Initial Portrait Pane Display",
	PROGBAROPT_INIT_PORT_DESC = "Select what the portrait pane will initially display when the Record screen is opened.",
	PROGBAROPT_INIT_PORTRAIT_LABEL = "Portrait",
	PROGBAROPT_INIT_PORTRAIT_DESCR = "Large character portrait will be initially displayed.",
	PROGBAROPT_INIT_ALTPORT_LABEL = "Alternate",
	PROGBAROPT_INIT_ALTPORT_DESCR = "Progress bars, small portrat, and stats summary will be initially displayed.",
	PROGBAROPT_INIT_LAST_LABEL = "Previous",
	PROGBAROPT_INIT_LAST_DESCR = "Whatever was visible the last time the Record screen was shown will be displayed.",
}

for k,v in pairs(pgBarStrings) do
	uiStrings[k]=v
end


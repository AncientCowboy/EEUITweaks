
Infinity_RegisterFile("en_USPgB.lua")
if(uiTranslationFile) then
	Infinity_RegisterFile(string.sub(uiTranslationFile,1,3).."PgB.lua")
end

MixIdtoClassIdMap = {}
ClassIdToXPLevelMap = {}

Infinity_DoFile("YZ_PgBar.lua") -- Loads MixIdtoClassIdMap
Infinity_DoFile("WX_PgBar.lua") -- Loads ClassIdToXPLevelMap


local u8asciiMatchString
u8asciiMatchString = "^([^:]-)%s*:%D+(%d+)"
local u3colonMatchString
u3colonMatchString = "^(..-)[\239][\188][\154]%D-(%d+)"
local nbspaceMatchString
nbspaceMatchString = "^([^:]-)[\194][\160]:%D+(%d+)"

local LanguageMatch
LanguageMatch = {
	['zh_CN'] = u3colonMatchString,
	['cs_CZ'] = u8asciiMatchString,
	['en_US'] = u8asciiMatchString,
	['fr_FR'] = nbspaceMatchString,
	['de_DE'] = u8asciiMatchString,
	['it_IT'] = u8asciiMatchString,
	['ja_JP'] = u3colonMatchString,
	['ko_KR'] = u8asciiMatchString,
	['nb_NO'] = u8asciiMatchString, 
	['pl_PL'] = u8asciiMatchString,
	['pt_BR'] = u8asciiMatchString,
	['ru_RU'] = u8asciiMatchString,
	['es_ES'] = u8asciiMatchString,
	['tr_TR'] = u8asciiMatchString,
	['uk_UA'] = u8asciiMatchString,
	['hu_HU'] = u8asciiMatchString
}

--[[ KitStringToXPMap table entries
['Initialized']  => true (once KitString initialization is complete)
['IniInited'] => true once INI file info has been initialized
['Matchstring']  => appropriate language specific match string from LanguageMatch.
Used to parse kit name and current level from characters[currentID].claslevel.first/second/third.details string
[first kit name] => 
    {[1] MIXEDID,
     [2] => {[1]  Level 1 XP
             [2]  Level 2 XP
             ...
             [41] Level 41 XP
            }
    }
    ...
[sixtieth kit name] =>
    {[1] MIXEDID,
     [2] => {[1]  Level 1 XP
             [2]  Level 2 XP
             ...
             [41] Level 41 XP
            }
    }
['Color'] => 0xBBGGRR Progress bar filling color
['Full']  => 0xBBGGRR Progress bar full color
['NoMult'] => true inhibit multi-class 'real XP' multiplier
['NoDelta'] => true absolute progress bar vs. relative to last level up
['NoLevel'] => true inhibits going to level up screen when progress bar clicked
['DualEmpty'] => true second level (initial class) progress bar for Dual-class characters will
                 appear empty when initial class is reactivated. False it will appear full
['DualGrey'] => true second level (initial class) progress bar will be grey-scale rather than
                color for dual-class characters				 
['NoPortrait'] => true disables portrait click alternate display
['FirstPortrait'] => 0 as last, 1 portrait, 2 alternate display
['NoCombat'] => true disables combat stats on alternate display
['BarsBottom'] => true makes small portrait (and combat stats) appear above the 
                  progress bars on alternate display
]]
	
local KitStringToXPMap
KitStringToXPMap = {}

local function initializeXPMapKits()
	for k,v in pairs(MixIdtoClassIdMap) do
--		tstr = Infinity_FetchString(k)
--		Infinity_Log(tostring(k) .. " -> " .. tstr .. " -> " .. tostring(v) .. "\n")
		KitStringToXPMap[Infinity_FetchString(k)] = {k,ClassIdToXPLevelMap[v]}
	end
	if(uiTranslationFile) then
		KitStringToXPMap['Matchstring'] = LanguageMatch[uiTranslationFile]
	else
		KitStringToXPMap['Matchstring'] = LanguageMatch['en_US']
	end
end

function prgBarUpdateOptions()
	local v1, v2, v3, inioptionsset

	inioptionsset = Infinity_GetINIValue('Progress Bar', 'IniOptionsSet')
	v1 = Infinity_GetINIValue('Progress Bar','Color Red'  ) % 256
	v2 = Infinity_GetINIValue('Progress Bar','Color Green') % 256
	v3 = Infinity_GetINIValue('Progress Bar','Color Blue' ) % 256
	if(v1 ~= 0 and v2 ~= 0 and v3 ~= 0) then
		inioptionsset = 1
	end
	KitStringToXPMap['Color'] = bit32.bor(bit32.bor(bit32.lshift(v3,16),bit32.lshift(v2, 8)),v1)

	v1 = Infinity_GetINIValue('Progress Bar','Full Red'  ) % 256
	v2 = Infinity_GetINIValue('Progress Bar','Full Green') % 256
	v3 = Infinity_GetINIValue('Progress Bar','Full Blue' ) % 256
	if(v1 ~= 0 and v2 ~= 0 and v3 ~= 0) then
		inioptionsset = 1
	end
	KitStringToXPMap['Full']  = bit32.bor(bit32.bor(bit32.lshift(v3,16),bit32.lshift(v2, 8)),v1)

	v1 = Infinity_GetINIValue('Progress Bar','Disable Multiplier')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['NoMult'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['NoMult'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Disable Deltas')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['NoDelta'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['NoDelta'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Disable Level Up')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['NoLevel'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['NoLevel'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Empty Dual Enabled')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['DualEmpty'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['DualEmpty'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Grey Scale Dual-Class')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['DualGrey'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['DualGrey'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Disable Portrait Alternate')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['NoPortrait'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['NoPortrait'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Disable Combat Stats')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['NoCombat'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['NoCombat'] = false
	end

	v1 = Infinity_GetINIValue('Progress Bar','Initial Display')
	if(v1 and v1 == 1) then	
		KitStringToXPMap['FirstPortrait'] = 1
		inioptionsset = 1
	elseif(v1 and v1 == 2) then	
		KitStringToXPMap['FirstPortrait'] = 2
		inioptionsset = 1
	else
		KitStringToXPMap['FirstPortrait'] = 0	
	end
	
	v1 = Infinity_GetINIValue('Progress Bar','Bars On Bottom')
	if(v1 and v1 ~= 0) then	
		KitStringToXPMap['BarsBottom'] = true
		inioptionsset = 1
	else
		KitStringToXPMap['BarsBottom'] = false
	end

	if(inioptionsset == 0) then -- All options were zero including the tag that is written to 1 when Options Menu saves. Set default colors
		v1 = 128
		v2 = 0
		v3 = 0
		Infinity_SetINIValue('Progress Bar','Color Red', v1)
		Infinity_SetINIValue('Progress Bar','Color Green', v2)
		Infinity_SetINIValue('Progress Bar','Color Blue', v3 )
		KitStringToXPMap['Color'] = bit32.bor(bit32.bor(bit32.lshift(v3,16),bit32.lshift(v2, 8)),v1)
		Infinity_SetINIValue('Progress Bar','Full Red', v1)
		Infinity_SetINIValue('Progress Bar','Full Green', v2)
		Infinity_SetINIValue('Progress Bar','Full Blue', v3 )
		KitStringToXPMap['Full'] = bit32.bor(bit32.bor(bit32.lshift(v3,16),bit32.lshift(v2, 8)),v1)
		Infinity_SetINIValue('Progress Bar','IniOptionsSet', 1 )
	end

end

--[[
Called in CHARACTER:onopen
]]
function initPgBarMods()
	if (not(KitStringToXPMap['Initialized'])) then
		initializeXPMapKits()
		KitStringToXPMap['Initialized'] = true
	end

	if (not(KitStringToXPMap['IniInited'])) then
		prgBarUpdateOptions()
		KitStringToXPMap['IniInited'] = true
	end
end

function initPgBarOptions()
	if (not(KitStringToXPMap['IniInited'])) then
		prgBarUpdateOptions()
		KitStringToXPMap['IniInited'] = true
	end
end

local function getDualToActivate()
	local need, have = 0, 0
	local dontcare, secondlevel = 
		string.match(characters[currentID].classlevel.second.details, 
					 KitStringToXPMap['Matchstring'])
	secondlevel = tonumber(secondlevel)
	
	local firstlevel
	dontcare, firstlevel = string.match(characters[currentID].classlevel.first.details, 
										 KitStringToXPMap['Matchstring'])
	firstlevel = tonumber(firstlevel)
	if(firstlevel and secondlevel) then
		if(firstlevel <= secondlevel) then
			need = KitStringToXPMap[dontcare][2][secondlevel+1] 
			have = characters[currentID].classlevel.first.xp
		end
	end
	return need, have
end
--[[
Returns the XP base value for the kit and level described by string 'targetDetails'
]]
local function getCurrentLevelBaseXP(targetDetails)
	local currentlevelxp = 0

	-- Capture kit name, current level from targetDetails string
	local targetKit,targetLevel = string.match(targetDetails, KitStringToXPMap['Matchstring'])
	if	( -- Fail safe for kit strings that haven't yet been put into language files
		targetKit and 
		targetLevel and
		#targetKit > 0 and
		not string.match(targetKit, "placeholder") and
		KitStringToXPMap[targetKit]
		) 
	then
		currentlevelxp = KitStringToXPMap[targetKit][2][tonumber(targetLevel)]
	end
	return currentlevelxp
end

--[[
Returns current XP value and next (soonest) level up XP val, as deltas if Delta enabled.
Used to fill 'overall' progressbar via 'getPercent'
]]
function getNextLevelXPDeltas()
-- If can't determine language or 'NoDelta' option set, return non-delta values
	if ((not KitStringToXPMap['Matchstring']) or KitStringToXPMap['NoDelta']) then
		return characters[currentID].level.xp, characters[currentID].level.nextLvlXp
	end

--[[ 
Array of current char/current level base XP for each class that is defined, allowed
(e.g. not dual initial class) to level up, and whose next level up XP is the same as
the char's 'nextLvlXp' value.
]]
	local candidates = {} 
	
	if	(
		characters[currentID].classlevel.third and
		characters[currentID].classlevel.third.active and
		characters[currentID].classlevel.third.nextLvlXp == characters[currentID].level.nextLvlXp
		)
	then
		candidates[#candidates+1] = getCurrentLevelBaseXP(characters[currentID].classlevel.third.details)
	end
	
	if	(
		characters[currentID].classlevel.second and
		characters[currentID].classlevel.second.active and
		characters[currentID].classlevel.second.nextLvlXp == characters[currentID].level.nextLvlXp
		)
	then
		candidates[#candidates+1] = getCurrentLevelBaseXP(characters[currentID].classlevel.second.details)
	end
	
	if (characters[currentID].classlevel.first.nextLvlXp == characters[currentID].level.nextLvlXp) then
		candidates[#candidates+1] = getCurrentLevelBaseXP(characters[currentID].classlevel.first.details)
	end
		
	local currentlevelxp
	if(#candidates > 0) then
		currentlevelxp = candidates[1]
-- If more than 1, keep the one with the most 'recent' (greatest) base.
		for i = 2, #candidates do
			currentlevelxp = math.max(currentlevelxp, candidates[i])
		end
	else
		currentlevelxp = 0 -- Something is bogus, fail safe
	end

	return characters[currentID].level.xp - currentlevelxp, characters[currentID].level.nextLvlXp - currentlevelxp
end	

function getFirstLevelXPDeltas()
	local currentlevelxp = 0
	if(not KitStringToXPMap['NoDelta']) then
		currentlevelxp = getCurrentLevelBaseXP(characters[currentID].classlevel.first.details)
	end
	return characters[currentID].classlevel.first.xp - currentlevelxp, 
	       characters[currentID].classlevel.first.nextLvlXp - currentlevelxp
end

function getSecondLevelXPDeltas()  
	if(not characters[currentID].classlevel.second) then  -- Fail safe
		return characters[currentID].level.xp, characters[currentID].level.nextLvlXp
	end
	
	local currentlevelxp = 0
	local need, have
	if (characters[currentID].classlevel.second.active) then -- Multi-class
		need = characters[currentID].classlevel.second.nextLvlXp
		have = characters[currentID].classlevel.second.xp
		if(KitStringToXPMap['Matchstring'] and not(KitStringToXPMap['NoDelta'])) then
			currentlevelxp = getCurrentLevelBaseXP(characters[currentID].classlevel.second.details)
		end
	else   --Dual-class
		need, have = getDualToActivate()
		if(have >= need) then
			if(KitStringToXPMap['DualEmpty']) then -- Dual class empty
				need = characters[currentID].level.nextLvlXp
				have = 0
			else                  -- Dual class full
				need = characters[currentID].classlevel.second.xp*1000
				have = need
			end
		end
	end

	return have - currentlevelxp, need - currentlevelxp
end

function getThirdLevelXPDeltas()
	if(not characters[currentID].classlevel.third) then -- Fail safe
		return characters[currentID].level.xp, characters[currentID].level.nextLvlXp
	end
	
	local currentlevelxp = 0
	if(KitStringToXPMap['Matchstring'] and (not KitStringToXPMap['NoDelta'])) then
		currentlevelxp = getCurrentLevelBaseXP(characters[currentID].classlevel.third.details)
	end
	return characters[currentID].classlevel.third.xp - currentlevelxp, 
	       characters[currentID].classlevel.third.nextLvlXp - currentlevelxp
end

function getFirstLevelLabel()
	local targetKit,targetLevel = string.match(characters[currentID].classlevel.first.details,
	                                           KitStringToXPMap['Matchstring'])
	return targetKit .. ': ' .. t("PGBAR_LEVEL_LABEL") .. ' '.. targetLevel
end

function getSecondLevelLabel()
	if(not characters[currentID].classlevel.second) then  -- Fail safe
		return ""
	end
	
	local targetKit,targetLevel = string.match(characters[currentID].classlevel.second.details,
	                                           KitStringToXPMap['Matchstring'])
	return targetKit .. ': ' .. t("PGBAR_LEVEL_LABEL") .. ' '.. targetLevel
end

function getThirdLevelLabel()
	if(not characters[currentID].classlevel.third) then  -- Fail safe
		return ""
	end
	
	local targetKit,targetLevel = string.match(characters[currentID].classlevel.third.details,
	                                           KitStringToXPMap['Matchstring'])
	return targetKit .. ': ' .. t("PGBAR_LEVEL_LABEL") .. ' '.. targetLevel
end

function getCombatString()
	local str = t("PGBAR_AC_LABEL") .. ' : ' .. characters[currentID].AC.current .. '\n'
	str = str .. t("PGBAR_HP_LABEL") .. ' : ' .. characters[currentID].HP.current .. '/' .. characters[currentID].HP.max .. '\n'
	str = str .. t("PGBAR_THAC0_LABEL") .. ' : ' .. characters[currentID].THAC0.current 
	if(characters[currentID].THAC0.offhand) then
		str = str .. '/' .. characters[currentID].THAC0.offhand
	end
	str = str .. '\n'
	str = str .. t("PGBAR_DAMAGE_LABEL") .. ' : ' .. characters[currentID].damage.min .. '-' .. characters[currentID].damage.max ..'\n'
	if(characters[currentID].damage.maxOffhand) then
		str = str .. t('PGBAR_OFFHAND_LABEL') .. ' : '  .. characters[currentID].damage.minOffhand .. '-' .. characters[currentID].damage.maxOffhand
	end
	return str
end
	
function firstCanLevelUp()
	if(KitStringToXPMap['NoLevel']) then
		return false
	else
		return (characters[currentID].classlevel.first.xp >= characters[currentID].classlevel.first.nextLvlXp)
	end
end

function secondCanLevelUp()
	local rtnval = false
	if(not KitStringToXPMap['NoLevel']) then
		if(characters[currentID].classlevel.second and characters[currentID].classlevel.second.active) then
			rtnval = characters[currentID].classlevel.second.xp >= characters[currentID].classlevel.second.nextLvlXp
		end
	end
	return rtnval
end

function thirdCanLevelUp()
	local rtnval = false
	if(not KitStringToXPMap['NoLevel']) then
		if(characters[currentID].classlevel.third) then
			rtnval = characters[currentID].classlevel.third.xp >= characters[currentID].classlevel.third.nextLvlXp
		end
	end
	return rtnval
end

local function getMultiplier()
	local multiplier = 1
	if (not(KitStringToXPMap['NoMult'] or (characters[currentID].race == 1096))) then
		if (characters[currentID].classlevel.third) then
			multiplier = 3
		elseif (characters[currentID].classlevel.second) then
			multiplier = 2
		end
	end
	return multiplier
end

local function getLevelString(dualoriginal, nextLevelXp, multiplier)
	local str = ""
	
	if(not nextLevelXp) then  --Parsing for levels failed
		str = t("PGBAR_UNKNOWN_LABEL")
	elseif(dualoriginal) then
		if(nextLevelXp > 0) then
			str = t("PGBAR_ENABLE_LABEL")
			str = str .. " "
			str = str .. nextLevelXp
			str = str .. " "
			str = str .. t("PGBAR_XP_LABEL")
		else
			str = t("PGBAR_ENABLED_LABEL")		
		end
	elseif(nextLevelXp > 0) then
		str = t("PGBAR_NEXT_LEVEL_LABEL")
		str = str .. " "
		str = str .. nextLevelXp * multiplier
		str = str .. " "
		str = str .. t("PGBAR_XP_LABEL")
	else
		str = t("PGBAR_READY_TO_LEVEL_LABEL")
	end
	return str
end

function getAdjustedNextLevelString(targetclasslevel)
	local multiplier = getMultiplier()
	local nextLevelXp = characters[currentID].level.nextLvlXp - 
	                    characters[currentID].level.xp
	return getLevelString(false, nextLevelXp, multiplier)
end

function getAdjustedFirstLevelString()	
	local multiplier = getMultiplier()
	local nextLevelXp = characters[currentID].classlevel.first.nextLvlXp - 
	                    characters[currentID].classlevel.first.xp
	return getLevelString(false, nextLevelXp, multiplier)
end

function getAdjustedSecondLevelString()
	local multiplier = getMultiplier()
	local dualoriginal = false
	local nextLevelXp
	if(characters[currentID].classlevel.second) then
		if(characters[currentID].classlevel.second.active) then
			nextLevelXp = characters[currentID].classlevel.second.nextLvlXp - 
			              characters[currentID].classlevel.second.xp
		else
			local need, have = getDualToActivate()
			nextLevelXp = need - have
			dualoriginal = true
		end
	end
	return getLevelString(dualoriginal, nextLevelXp, multiplier)
end

function getAdjustedThirdLevelString()
	local multiplier = getMultiplier()
	local nextLevelXp
	if(characters[currentID].classlevel.third) then
		nextLevelXp = characters[currentID].classlevel.third.nextLvlXp - 
		              characters[currentID].classlevel.third.xp
	end
	return getLevelString(false, nextLevelXp, multiplier)
end
		
function prgBarColor()
	return KitStringToXPMap['Color']
end

function prgBarFull()
	return KitStringToXPMap['Full']
end

function prgBarLevelUpEnabled()
	return not(KitStringToXPMap['NoLevel'])
end

function prgBarGreyScale()
	if(not KitStringToXPMap['DualGrey']) then
		return 0
	else
		return (not(characters[currentID].classlevel.second.active) and 1) or 0
	end
end

function prgBarHideEnabled()
	return not(KitStringToXPMap['NoPortrait'])
end

function prgBarCombatEnabled()
	return not(KitStringToXPMap['NoCombat'])
end

function prgBarCombatDisabled()
	return (KitStringToXPMap['NoCombat'])
end

function prgBarPBarsTop()
	return not(KitStringToXPMap['BarsBottom'])
end

function prgBarPBarsBottom()
	return (KitStringToXPMap['BarsBottom'])
end

--[[
Called in CHARACTER:onopen, passed current value of 'hidePortrait', 
returns value to be assigned to 'hidePortrait'.
Return value is based on 'FirstPortrait' option
]]
function prgBarInitialDisplay(hidePortrait)
	if(KitStringToXPMap['NoPortrait']) then 
		return false
	elseif(KitStringToXPMap['FirstPortrait'] == 0) then -- Prior
		return hidePortrait
	elseif(KitStringToXPMap['FirstPortrait'] == 1) then -- Portrait
		return false
	else -- ['FirstPortrait'] == 2 Alternate
		return true
	end
end

-- Progress Bar Options resources
-- Label Key, Description Key, toggle frame, toggle value, INI section name, INI option key  
progBarOptionsToggles = {
	{"PROGBAROPT_DISABLE_MULTIPLIER_LABEL",	"PROGBAROPT_DISABLE_MULTIPLIER_DESCR",	0,	0,	"Progress Bar",	"Disable Multiplier"},
	{"PROGBAROPT_DISABLE_DELTAS_LABEL",		"PROGBAROPT_DISABLE_DELTAS_DESCR",		0,	0,	"Progress Bar",	"Disable Deltas"},
	{"PROGBAROPT_DISABLE_LEVELUP_LABEL",	"PROGBAROPT_DISABLE_DEVELUP_DESCR", 	0,	0,	"Progress Bar",	"Disable Level Up"},
	{"PROGBAROPT_ENABLE_EMPTYDUAL_LABEL",	"PROGBAROPT_ENABLE_EMPTYDUAL_DESCR", 	0,	0,	"Progress Bar",	"Empty Dual Enabled"},
	{"PROGBAROPT_GREY_SCALE_DUAL_LABEL",	"PROGBAROPT_GREY_SCALE_DUAL_DESCR", 	0,	0,	"Progress Bar",	"Grey Scale Dual-Class"},
	{"PROGBAROPT_DISABLE_PORTRAIT_LABEL",	"PROGBAROPT_DISABLE_PORTRAIT_DESCR", 	0,	0,	"Progress Bar",	"Disable Portrait Alternate"},
	{"PROGBAROPT_DISABLE_COMBAT_LABEL",	    "PROGBAROPT_DISABLE_COMBAT_DESCR", 	    0,	0,	"Progress Bar",	"Disable Combat Stats"},
	{"PROGBAROPT_BARS_BOTTOM_LABEL",	    "PROGBAROPT_BARS_BOTTOM_DESCR", 	    0,	0,	"Progress Bar",	"Bars On Bottom"},
}

pstprogBarOptionsToggles = {
	{"PROGBAROPT_DISABLE_MULTIPLIER_LABEL",	"PROGBAROPT_DISABLE_MULTIPLIER_DESCR",	0,	0,	"Progress Bar",	"Disable Multiplier"},
	{"PROGBAROPT_DISABLE_DELTAS_LABEL",		"PROGBAROPT_DISABLE_DELTAS_DESCR",		0,	0,	"Progress Bar",	"Disable Deltas"},
	{"PROGBAROPT_DISABLE_COMBAT_LABEL",	    "PROGBAROPT_DISABLE_COMBAT_DESCR", 	    0,	0,	"Progress Bar",	"Disable Combat Stats"},
}

-- slider value, INI section name, INI option key
progBarColorSliders = {
	{0,	"Progress Bar",	"Color Red"},
	{0,	"Progress Bar",	"Color Green"},
	{0,	"Progress Bar",	"Color Blue"},
}

-- slider value, INI section name, INI option key
progBarFullSliders = {
	{0,	"Progress Bar",	"Full Red"},
	{0,	"Progress Bar",	"Full Green"},
	{0,	"Progress Bar",	"Full Blue"},
}

-- Portrait frame, Portrait state, Alternate frame, Alternate state, Prior frame, Prior state 
progBarInitialRadio = {
	{0,	0,	0,	0,	0,	0},
}

currentProgBarInfo = 0
currentProgBarIdx = 0
currentProgBarSlider = 0
currentProgBarRadio = 0

function progBarGetToggleOption(idx)
	return Infinity_GetINIValue(progBarOptionsToggles[idx][5], progBarOptionsToggles[idx][6])
end

function pstprogBarGetToggleOption(idx)
	return Infinity_GetINIValue(pstprogBarOptionsToggles[idx][5], pstprogBarOptionsToggles[idx][6])
end

function progBarSaveToggleOption(idx)
	Infinity_SetINIValue(progBarOptionsToggles[idx][5], progBarOptionsToggles[idx][6], progBarOptionsToggles[idx][4])
end

function pstprogBarSaveToggleOption(idx)
	Infinity_SetINIValue(pstprogBarOptionsToggles[idx][5], pstprogBarOptionsToggles[idx][6], pstprogBarOptionsToggles[idx][4])
end

function progBarGetFillOption(idx)
	local rval = Infinity_GetINIValue(progBarColorSliders[idx][2], progBarColorSliders[idx][3])
	return (rval == 255) and 128 or math.floor(rval/2)
end

function progBarGetFillColor()
	local r = (progBarColorSliders[1][1] == 128) and 255 or progBarColorSliders[1][1]*2
	local g = (progBarColorSliders[2][1] == 128) and 255 or progBarColorSliders[2][1]*2
	local b = (progBarColorSliders[3][1] == 128) and 255 or progBarColorSliders[3][1]*2
	return bit32.bor(bit32.bor(bit32.lshift(b,16),bit32.lshift(g, 8)),r)
end

function progBarGetFillText()
	local r = (progBarColorSliders[1][1] == 128) and 255 or progBarColorSliders[1][1]*2
	local g = (progBarColorSliders[2][1] == 128) and 255 or progBarColorSliders[2][1]*2
	local b = (progBarColorSliders[3][1] == 128) and 255 or progBarColorSliders[3][1]*2
	return string.format("%d %d %d", r, g, b)
end

function progBarSaveFillOption(idx)
	Infinity_SetINIValue(progBarColorSliders[idx][2], progBarColorSliders[idx][3], 
	                     ((progBarColorSliders[idx][1]==128) and 255 or (progBarColorSliders[idx][1]*2)))
end

function progBarGetFullOption(idx)
	local rval = Infinity_GetINIValue(progBarFullSliders[idx][2], progBarFullSliders[idx][3])
	return (rval == 255) and 128 or math.floor(rval/2)
end

function progBarGetFullColor()
	local r = (progBarFullSliders[1][1] == 128) and 255 or progBarFullSliders[1][1]*2
	local g = (progBarFullSliders[2][1] == 128) and 255 or progBarFullSliders[2][1]*2
	local b = (progBarFullSliders[3][1] == 128) and 255 or progBarFullSliders[3][1]*2
	return bit32.bor(bit32.bor(bit32.lshift(b,16),bit32.lshift(g, 8)),r)
end

function progBarGetFullText()
	local r = (progBarFullSliders[1][1] == 128) and 255 or progBarFullSliders[1][1]*2
	local g = (progBarFullSliders[2][1] == 128) and 255 or progBarFullSliders[2][1]*2
	local b = (progBarFullSliders[3][1] == 128) and 255 or progBarFullSliders[3][1]*2
	return string.format("%d %d %d", r, g, b)
end

function progBarSaveFullOption(idx)
	Infinity_SetINIValue(progBarFullSliders[idx][2], progBarFullSliders[idx][3], 
	                     ((progBarFullSliders[idx][1]==128) and 255 or (progBarFullSliders[idx][1]*2)))
end

function progBarGetPortraitOption()
	local val = Infinity_GetINIValue("Progress Bar","Initial Display")
	for k = 1, #(progBarInitialRadio[1]) do
		progBarInitialRadio[1][k] = 0
	end
	if(val and val == 2) then
		progBarInitialRadio[1][1] = 2
		progBarInitialRadio[1][4] = 1
		progBarInitialRadio[1][5] = 2
	elseif(val and val == 1) then
		progBarInitialRadio[1][2] = 1
		progBarInitialRadio[1][3] = 2
		progBarInitialRadio[1][5] = 2
	else
		progBarInitialRadio[1][1] = 2
		progBarInitialRadio[1][3] = 2
		progBarInitialRadio[1][6] = 1
	end
end

function progBarUpdatePortraitRadioState(cellNumber)
	if(cellNumber % 2 == 0) then cellNumber = cellNumber - 1 end -- Labels
	if(progBarInitialRadio[1][cellNumber] == 1) then return end -- Clicked already set
	if(cellNumber == 1) then
		progBarInitialRadio[1][1] = 0
		progBarInitialRadio[1][2] = 1
		progBarInitialRadio[1][3] = 2
		progBarInitialRadio[1][4] = 0
		progBarInitialRadio[1][5] = 2
		progBarInitialRadio[1][6] = 0
	elseif(cellNumber == 3) then
		progBarInitialRadio[1][1] = 2
		progBarInitialRadio[1][2] = 0
		progBarInitialRadio[1][3] = 0
		progBarInitialRadio[1][4] = 1
		progBarInitialRadio[1][5] = 2
		progBarInitialRadio[1][6] = 0
	else
		progBarInitialRadio[1][1] = 2
		progBarInitialRadio[1][2] = 0
		progBarInitialRadio[1][3] = 2
		progBarInitialRadio[1][4] = 0
		progBarInitialRadio[1][5] = 0
		progBarInitialRadio[1][6] = 1
	end
end

function progBarSavePortraitOption()
	local val = (progBarInitialRadio[1][2] == 1 and 1) or (progBarInitialRadio[1][4] == 1 and 2) or 0
	Infinity_SetINIValue('Progress Bar', 'Initial Display', val)
	Infinity_SetINIValue('Progress Bar', 'IniOptionsSet', 1)
end

function getPercent(first, second)
	tempNumber = ( first/second ) *100
	return tempNumber
end



`
TEXT_inventoryError = ""
inventoryStats = {}
inventoryShow = {1,1,1,1,1,1}
savedID = 0
savedHeight = 0
itemComparison = true
forceGroundScroll = false

function resetStatsDisplay()
	tempStats = {}
end
function slotDoubleClick(slotName, force)
	local slot = characters[id].equipment[slotName]

	if(string.sub(slotName,1,6) == "ground" and force == nil) then
		--this hack is needed because unlike other slots, ground item add/remove is a message (doesnt get executed immediately)
		--since the double click removes the item before re-adding it, we need to wait for that re-add to complete before continuing.
		doubleClickEventScheduled = slotName
		return
	end

	if(slot ~= nil) then
		if(slot.item.isBag ~= 0) then
			Infinity_OpenInventoryContainer(slot.item.res)
		else
			showItemAmountRequester(slotName)
		end
	end
end
function checkDoubleClickScheduled(slotName)
	if(doubleClickEventScheduled == slotName) then
		slotDoubleClick(doubleClickEventScheduled, true)
		doubleClickEventScheduled = nil
	end
end
function shouldGreyOutInventory()
	return characters[id].HP.current <= 0 or inventoryScreen:IsSpriteOrderable() == false
end
function getInventoryTHAC0()
	local str = characters[id].THAC0.current
	if(characters[id].THAC0.offhand) then
		str = str .. "\n" .. characters[id].THAC0.offhand
	end
	return str
end
function getInventoryDamage()
	local str = characters[id].damage.min .. ' - ' .. characters[id].damage.max
	if(characters[id].damage.minOffhand and characters[id].damage.maxOffhand) then
		str = str .. "\n" .. characters[id].damage.minOffhand .. ' - ' .. characters[id].damage.maxOffhand
	end
	return str
end
function scrollGroundItems()
	if scrollDirection > 0 then
		Infinity_OnGroundPage(-1)
		forceGroundScroll = true
	elseif scrollDirection < 0 then
		Infinity_OnGroundPage(1)
		forceGroundScroll = true
	end
end
function formatString(value, score, coeff)
	local str = value .. " (-)"
	if score < 0 then
		str = value .. " (" .. score .. ")"
	elseif score > 0 then
		str = value .. " (+" .. score .. ")"
	end
	if coeff * score < 0 then return "^R" .. str .. "^-" end
	if coeff * score > 0 then return "^G" .. str .. "^-" end
	return str
end
function getTempStat(old, newName, name, coeff)
	local new = tempStats[id][newName]
	local score = (new - old)
	if score ~= 0 then
		local str = formatString(new, score, coeff)
		table.insert(inventoryStats, {3,name,str})
	end
end
function getTempDamage()
	local dmgMinTemp = tempStats[id]['dmgMin']
	local dmgMaxTemp = tempStats[id]['dmgMax']
	if characters[id].damage.min ~= dmgMinTemp or characters[id].damage.max ~= dmgMaxTemp then
		local old = (characters[id].damage.min + characters[id].damage.max) / 2
		local new = (dmgMinTemp + dmgMaxTemp) / 2
		local score = (new - old)
		local str = formatString(dmgMinTemp .. '-' .. dmgMaxTemp, score, 1)
		table.insert(inventoryStats, {3,t("DAMAGE_LABEL"),str})
	end
end
function buildInventoryStats()
	inventoryStats = {}

	if(itemComparison and tempStats[id] ~= nil) then
		getTempStat(characters[id].AC.current,'AC',t("ARMOR_CLASS_LABEL"),-1)
		getTempStat(characters[id].HP.max,'maxHP',t("HIT_POINTS_LABEL"),1)
		getTempStat(characters[id].THAC0.current,'THAC0',t("THAC0_LABEL"),-1)
		getTempDamage()
		if length(inventoryStats) ~= 0 then
			table.insert(inventoryStats, 1, {1,tempStats[id].tempItem})
			return inventoryStats
		end
	end

	table.insert(inventoryStats, {1,t("ARMOR_CLASS_LABEL"),1})
	if inventoryShow[1] == 1 then
		table.insert(inventoryStats, {2,characters[id].AC.details})
	end

	table.insert(inventoryStats, {1,t("HIT_POINTS_LABEL"),2})
	if inventoryShow[2] == 1 then
		table.insert(inventoryStats, {2,characters[id].HP.details})
	end

	if (characters[id].THAC0.detailsOffhand ~= nil and characters[id].THAC0.detailsOffhand ~= "") then
		table.insert(inventoryStats, {1,t("MAIN_HAND_THAC0"),3})
		if inventoryShow[3] == 1 then
			table.insert(inventoryStats, {2,characters[id].THAC0.details})
		end
		table.insert(inventoryStats, {1,t("OFF_HAND_THAC0"),4})
		if inventoryShow[4] == 1 then
			table.insert(inventoryStats, {2,characters[id].THAC0.detailsOffhand})
		end
	else
		table.insert(inventoryStats, {1,t("THAC0_LABEL"),3})
		if inventoryShow[3] == 1 then
			table.insert(inventoryStats, {2,characters[id].THAC0.details})
		end
	end

	if (characters[id].damage.maxOffhand) then
		table.insert(inventoryStats, {1,t("MAIN_HAND_DAMAGE"),5})
		if inventoryShow[5] == 1 then
			table.insert(inventoryStats, {2,characters[id].damage.details})
		end
		table.insert(inventoryStats, {1,t("OFF_HAND_DAMAGE"),6})
		if inventoryShow[6] == 1 then
			table.insert(inventoryStats, {2,characters[id].damage.detailsOffhand})
		end
	else
		table.insert(inventoryStats, {1,t("DAMAGE_LABEL"),5})
		if inventoryShow[5] == 1 then
			table.insert(inventoryStats, {2,characters[id].damage.details})
		end
	end
	return inventoryStats
end
function inventoryScroll(top, height, contentHeight)
	savedHeight = contentHeight
	if id ~= savedID then
		savedID = id
		return 0
	end
	return nil
end
function makeTable(length)
	local t = {}
	for i=1,length do
		table.insert(t, 1, '')
	end
	return t
end
function groundScroll(top, height, contentHeight)
	local curPage = Infinity_GetCurrentGroundPage()

	if forceGroundScroll then
		forceGroundScroll = false
		return -curPage * 106
	end

	local page = math.floor((-top + 53) / 106)
	if page ~= curPage then
		Infinity_OnGroundPage(page - curPage)
	end
	return nil
end
`

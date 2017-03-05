`
function showItemDescriptionInventory(slotName)
	if(characters[id].equipment[slotName].empty ~= 0) then
		return
	end

	selectedSlot = slotName

	Infinity_CheckItemIdentify(characters[id].equipment[slotName].id)
	showItemDescription(characters[id].equipment[slotName], 0)
end

itemDesc = {}
function showItemDescription(item, mode)
	itemDesc = item
	itemDesc.mode = mode
	Infinity_PushMenu('ITEM_DESCRIPTION',0,0)
end

function itemDescLeftButtonEnabled()
	if(itemDesc.mode == 0) then
		return itemDesc.item.identified == 0 or itemDesc.abilityMode == 1
	end
	return 0
end
function itemDescLeftButtonText()
	if(itemDesc.mode == 0) then
		if(itemDesc.item.identified == 0) then
			return t("IDENTIFY_BUTTON") .. ': ' .. t("SPELL_BUTTON")
		end
		return t("ABILITIES_BUTTON")
	end
	return ""
end
function itemDescLeftButtonAction()
	if(itemDesc.mode == 0) then
		if(itemDesc.item.identified == 0) then
			Infinity_OnSpellIdentify(itemDesc.id);
			itemDesc.item = characters[id].equipment[selectedSlot].item --update itemDesc item
		else
			Infinity_PushMenu('ITEM_ABILITIES',0,0)
		end
	end
end

function itemDescRightButtonEnabled()
	if(itemDesc.mode == 0) then
		return itemDesc.item.identified == 0 or itemDesc.useMode ~= -1
	end
	return itemDesc.mode == 1 and itemDesc.item.isBag
end
function itemDescRightButtonText()
	if(itemDesc.mode == 0) then
		if(itemDesc.item.identified == 0) then
			return t("IDENTIFY_BUTTON") .. ': ' .. t("SCROLL_BUTTON")
		end
		return Infinity_GetUseButtonText(itemDesc.id, itemDesc.useMode)
	end
	return t('OPEN_CONTAINER_BUTTON')
end
function itemDescRightButtonAction()
	if(itemDesc.mode == 0) then
		if(itemDesc.item.identified == 0) then
			Infinity_OnScrollIdentify(itemDesc.id);
			itemDesc.item = characters[id].equipment[selectedSlot].item --update itemDesc item
		else
			Infinity_PopMenu()
			Infinity_OnUseButtonClick(itemDesc.id, itemDesc.useMode)
		end
	else
		storeScreen:OpenBag(itemDesc.item.res)
		Infinity_PopMenu()
	end
end
`

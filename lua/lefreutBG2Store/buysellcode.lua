`
store = {}
storeGroupItemsVar = 0
storeItemsVar = 0
function getStoreSlotHighlight(highlight)
	if (highlight == 0) then
		return 0
	end
	return 2
end
function storeSplitStack(count)
	if (count ~= 0) then
		storeScreen:SelectStoreItem(storeItemsVar - 1, true);
		storeScreen:SetStoreItemCount(storeItemsVar - 1, count);
	else
		storeScreen:SelectStoreItem(storeItemsVar - 1, false);
	end
end
function groupSplitStack(count)
	if (count ~= 0) then
		storeScreen:SelectGroupItem(storeGroupItemsVar - 1, true);
		storeScreen:SetGroupItemCount(storeGroupItemsVar - 1, count);
	else
		storeScreen:SelectGroupItem(storeGroupItemsVar - 1, false);
	end
end
function checkContainerText(normalStr, containerStr)
	if(storeScreen:IsContainer()) then
		return t(containerStr)
	end
	return t(normalStr)
end
function getItemUsages()
	local item = store.storeItems[rowNumber].item
	if(item.usages > 1) then
		return item.usages
	end
	if(item.stackSize > 1) then
		return item.stackSize
	end
	return 0
end
function canSteal()
	local nb = 0
	for _, v in pairs(store.storeItems) do
		if v.highlight == 1 then
			nb = nb + 1
		end
	end
	return nb > 0 and nb + #store.groupItems <= 16
end
`

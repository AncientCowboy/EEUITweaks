`
selectedSlot = nil
itemRequestAmt = 0

function showItemAmountRequester(slotName)
	local slot = characters[id].equipment[slotName]
	if (slot.item.count or 0) > 1 then
		selectedSlot = slotName
		popupRequester(slot.item.count, inventorySplitStack, false)
	end
end
function inventorySplitStack(cnt)
	Infinity_SplitItemStack(characters[id].equipment[selectedSlot].id, cnt, 'slot_inv_' .. characters[id].equipment[selectedSlot].id)
end
function isRequesterPlusMinusButtonClickable(minus)
	local amt = tonumber(itemRequestAmt) or 0
	if minus then return amt > 1 end
	return amt < requester.requesterMax
end
function requesterPlusMinusButtonClick(minus)
	local amt = tonumber(itemRequestAmt) or 0
	local delta = 1
	if minus then delta = -1 end
	itemRequestAmt = amt + delta
end

reverseDonateButtons = false
requester = {}
requester.requesterMax = 0
requester.requesterFunc = nil
requester.selling = false
`
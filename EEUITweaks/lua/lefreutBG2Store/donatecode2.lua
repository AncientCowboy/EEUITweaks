`
function getDonationFrame()
	if(store.hasDonated ~= nil and store.hasDonated == 1) then
		return 1
	else
		return 0
	end
end
function isStorePlusMinusButtonClickable(minus)
	local amt = tonumber(storeDonateAmountEdit) or 0
	if minus then return amt > 0 end
	return amt < game:GetPartyGold()
end
function storePlusMinusButtonClick(minus)
	local amt = tonumber(storeDonateAmountEdit) or 0
	local delta = 1
	if minus then delta = -1 end
	storeDonateAmountEdit = amt + delta
end
storeDonateAmountEdit = 0 --no longer used in ui, but the engine needs it.
reverseDonateButtons = true
`

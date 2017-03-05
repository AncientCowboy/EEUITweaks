`
previousTop = nil
scrolled = false
worldNPCDialogText = ""
worldPlayerDialogChoices = {}

function dialogEntryGreyed()
	return not worldScreen:GetInControlOfDialog()
end
function resizeDialog()
	previousTop = nil
	scrolled = false
end
function dialogScroll(top, height, contentHeight)
	if scrolled then
		if previousTop ~= nil and contentHeight > height then
			local b = previousTop - contentHeight + 28
			previousTop = nil
			return b
		end
		return nil
	end
	if top < -1 and previousTop ~= nil then
		previousTop = top
		return nil
	end
	if previousTop == -1 and top ~= previousTop then
		scrolled = true
		previousTop = math.max(height, contentHeight)
		return 0
	end
	previousTop = -1
	return -1
end
function getDialogEntryText(row)
	local text = worldPlayerDialogChoices[row - 2].text
	if (row == worldPlayerDialogSelection) then
		--Color the text white when selected
		text = string.gsub(text, "%^0xff212eff", "^0xFFFFFFFF")
	end
	return text
end
function mergeDialog(t)
	local dialog = {}
	for key, value in pairs(t) do
		dialog[key] = value
	end
	table.insert(dialog, 1, '')
	table.insert(dialog, 1, '')
	return dialog
end
`

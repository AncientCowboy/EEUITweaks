`
step = 1
worldNPCDialogText = ""
worldPlayerDialogChoices = {}

function dialogEntryGreyed()
	return not worldScreen:GetInControlOfDialog()
end

function resizeDialog()
	buildResponsesList()
	step = 1
end

function dialogScroll(top, height, contentHeight)
	if worldNPCDialogText == '' then
		return nil
	end
	
	if step == 1 then
		step = 2
		return -contentHeight
	end

	if -top > contentHeight - 500 then
		return -(contentHeight - 500)
	end

	return nil
end

function dragDialogMessagesY(newY)
	local x,y,w,hOld = Infinity_GetArea("worldDialogBackground")
	h = hOld - newY
	if h < 100 then
		newY = hOld - 100
	elseif h > 500 then
		newY = hOld - 500
	end

	adjustItemGroup({"dialogHandleY","worldDialogPortraitArea"},0,newY,0,0)
	adjustItemGroup({"worldDialogBackground","worldPlayerDialogChoicesList"},0,newY,0,-newY)
end

function getDialogEntryText(row)
	local text = worldPlayerDialogChoices[row - 2].text
	if (row == worldPlayerDialogSelection) then
		--Color the text white when selected
		text = string.gsub(text, "%^0xff212eff", "^0xFFFFFFFF")
	end
	return text
end

function getDialogText()
	local text = '\n' .. worldNPCDialogText:gsub('\n', ': ', 1)
	if worldMessageBoxText:sub(-text:len()) == text then
		return worldMessageBoxText:sub(1, worldMessageBoxText:len() - text:len())
	end
	return worldMessageBoxText
end

function makeDialogTable()
	local length = step == 1 and 1 or #worldPlayerDialogChoices + 2
	local t = {}
	for i=1,length do
		table.insert(t, 1, '')
	end
	return t
end
`

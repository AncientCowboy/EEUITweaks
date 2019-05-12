`
step = 1
worldNPCDialogText = ""
worldPlayerDialogChoices = {}

function dialogEntryGreyed()
	return not worldScreen:GetInControlOfDialog()
end

function getDialogPaddingText()
	local x,y,w,h = Infinity_GetArea("worldPlayerDialogChoicesList")
	local zoom = tonumber(Infinity_GetINIValue('Fonts','Zoom','100'))
	local dialogHeight = Infinity_GetContentHeight(styles.normal.font, w, worldNPCDialogText:gsub('\n', ': ', 1), styles.normal.point * zoom / 100, 0, styles.normal.useFontZoom) + 12
	local i = 1
	while i <= #worldPlayerDialogChoices do
		dialogHeight = dialogHeight + Infinity_GetContentHeight(styles.normal.font, w, worldPlayerDialogChoices[i].text, styles.normal.point * zoom / 100, 0, styles.normal.useFontZoom)
		i = i + 1
	end
	local text = ""
	local lineHeight = Infinity_GetContentHeight(styles.normal.font, w, text, styles.normal.point * zoom / 100, 0, styles.normal.useFontZoom)
	while dialogHeight + lineHeight < h do
		text = text .. "\n"
		lineHeight = Infinity_GetContentHeight(styles.normal.font, w, text, styles.normal.point * zoom / 100, 0, styles.normal.useFontZoom)
	end
	return text
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
	local length = step == 1 and 1 or #worldPlayerDialogChoices + 3
	local t = {}
	for i=1,length do
		table.insert(t, 1, '')
	end
	return t
end
`

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
	local dialogHeight = Infinity_GetContentHeight(styles.normal.font, w, getDialogText(2), styles.normal.point * zoom / 100, 0, styles.normal.useFontZoom) + 12
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

function getDialogText(row)
	local idx1 = worldMessageBoxText:len()
	local idx2 = worldNPCDialogText:len()

	while idx2 > 0 do
		local c1 = worldMessageBoxText:byte(idx1)
		local c2 = worldNPCDialogText:byte(idx2)

		if c1 ~= c2 then
			if c1 == 58 and worldMessageBoxText:byte(idx1 - 1) == c2 then
				idx1 = idx1 - 1
				c1 = worldMessageBoxText:byte(idx1)
			elseif c2 == 10 and worldNPCDialogText:byte(idx2 - 1) == c1 then
				idx2 = idx2 - 1
				c2 = worldNPCDialogText:byte(idx2)
			elseif c1 == 32 and c2 == 10 and worldMessageBoxText:byte(idx1 - 1) == 58 then
				idx1 = idx1 - 1
				c1 = 10
			end
		end

		if c1 ~= c2 then
			break
		end

		idx1 = idx1 - 1
		idx2 = idx2 - 1
	end

	return trim(row == 1 and worldMessageBoxText:sub(1, idx1) or worldMessageBoxText:sub(idx1 + 1))
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

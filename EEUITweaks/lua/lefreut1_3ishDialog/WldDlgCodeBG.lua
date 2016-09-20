`
	worldNPCDialogText = ""
	worldPlayerDialogChoices = {}
	savedText = ""
	initialTop = nil
	previousTop = 0

	function dialogEntryGreyed()
		return not worldScreen:GetInControlOfDialog()
	end

	function resizeDialog()
		savedText = ""
	end
	function dialogScroll(top)
		if top ~= previousTop then
			initialTop = nil
		end
		if savedText ~= worldNPCDialogText then
			savedText = worldNPCDialogText
			initialTop = nil
			if computeDialogText() ~= '' then
				initialTop = -Infinity_GetListHeight('dummyMessageBox')
			end
			previousTop = initialTop
		end
		return initialTop
	end
	function getDialogEntryText(row)
		if (row == 1 or row == 2) then return end
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
	function computeDialogText()
		local npcDialog = worldNPCDialogText:gsub('\n', ': ', 1)
		if worldMessageBoxText:len() > npcDialog:len() then
			return worldMessageBoxText:sub(1, worldMessageBoxText:len() - npcDialog:len() - 1)
		end
		return ''
	end
`

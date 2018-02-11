`
function makeSaveTable()
	if gameSaves.newSave == nil then
		local newSave = {}
		newSave.slotIndex = #gameSaves.files
		newSave.slotName = t('NEW_SAVE_LABEL')
		newSave.chapter = gameSaves.currentGameInfo.chapter
		newSave.time = gameSaves.currentGameInfo.time
		table.insert(gameSaves.files, 1, newSave)
		gameSaves.newSave = true
	end
	return makeTable(#gameSaves.files)
end
`

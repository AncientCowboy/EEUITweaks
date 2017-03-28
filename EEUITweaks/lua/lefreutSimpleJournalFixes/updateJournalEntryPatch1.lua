	table.sort(quest.objectives,compareByRecvTime)
	if stateType == const.ENTRY_TYPE_INFO then
		local entry = buildEntry(journalId, recvTime, stateType, chapter, timeStamp)
		table.insert(looseEntries,entry)
	end

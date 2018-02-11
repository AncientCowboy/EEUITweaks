`
currentPage = 0
currentSave = 0
forceScroll = false
function onScroll(nbPage)
	if scrollDirection > 0 and currentPage > 0 then
		currentPage = currentPage - 1
		forceScroll = true
	elseif scrollDirection < 0 and currentPage < nbPage then
		currentPage = currentPage + 1
		forceScroll = true
	end
end
function scrollFunc(top, height, contentHeight)
	if forceScroll then
		forceScroll = false
		return -currentPage * 134
	end
	currentPage = math.floor((-top + 67) / 134)
	return nil
end
function compareSaves(s1,s2)
	--return true if s1 comes before s2
	--show the most recent saves first
	return s1.fileTime > s2.fileTime
end
function sortSaves()
	table.sort(gameSaves.files,compareSaves)
end
function makeTable(length)
	local t = {}
	for i=1,length do
		table.insert(t, 1, '')
	end
	return t
end
`

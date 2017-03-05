`
createBioEdit = ""

function generateBioText()
	if currentChargenRace == nil or currentChargenClass == nil or currentChargenKit == nil then
		return
	end
	if bioClassData == nil or bioRaceData == nil then
		return
	end

	local MyRace = chargen.races[currentChargenRace].id
	local MyClass = chargen.class[currentChargenClass].id
	local MyKit = chargen.kit[currentChargenKit].id
	local colClass = 2 + Infinity_GetINIValue('Program Options','Active Campaign')
	local colRace = 1 + Infinity_GetINIValue('Program Options','Active Campaign')
	-- Go through each row of bioClassData
	for i=1,#bioClassData,1 do
		-- Check chargen.class and chargen.kit to find a match against the current row
		if MyClass == bioClassData[i][1] and MyKit == bioClassData[i][2] then
			createBioEdit = Infinity_FetchString(bioClassData[i][colClass])
		end
	end
	-- Go through each row of bioRaceData
	for i=1,#bioRaceData,1 do
		-- Check chargen.race to find a match against the current row
		if MyRace == bioRaceData[i][1] then
			createBioEdit = createBioEdit .. '\n\n' .. Infinity_FetchString(bioRaceData[i][colRace])
		end
	end
end
`

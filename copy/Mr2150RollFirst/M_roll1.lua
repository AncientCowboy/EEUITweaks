function randomise()
	RandGender = 0
	choosePortrait = 0
	toggleMale = 0
	toggleFemale = 0
	currentChargenRace = 0
	currentChargenClass = 0
	currentChargenKit = 0
	currentChargenAlignment = 0
	totalAbilities = 0
	if rollFirst == 0 then
		rollFirst = 1
	end
	
	storedStats = {}	
	for i=1,6,1 do
		storedStats[i] = 0
	end
	
	-- Gender
	if createCharScreen:GetCurrentStep() == 0 then
		RandGender = math.random(2)
		createCharScreen:OnMenuButtonClick()
		
		if RandGender == 1 then
			toggleMale = 1
			toggleFemale = 0
			createCharScreen:OnGenderSelectButtonClick(1)
		elseif RandGender == 2 then
			toggleMale = 0
			toggleFemale = 1
			createCharScreen:OnGenderSelectButtonClick(2)
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	
	-- Portrait
	if createCharScreen:GetCurrentStep() == 1 then
		createCharScreen:DecCurrentPortrait()
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Race
	if createCharScreen:GetCurrentStep() == 3 then
		createCharScreen:OnMenuButtonClick()
		currentChargenRace = math.random(#chargen.races)
		createCharScreen:OnRaceSelectButtonClick(chargen.races[currentChargenRace].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Class
	if createCharScreen:GetCurrentStep() == 4 then 
		createCharScreen:OnMenuButtonClick()
		currentChargenClass = math.random(#chargen.class)
		createCharScreen:OnClassSelectButtonClick(chargen.class[currentChargenClass].id)
		Infinity_PopMenu('CHARGEN_CLASS')
		createCharScreen:OnDoneButtonClick()
	end
	
	if createCharScreen:GetCurrentStep() == 5 then
	end
	
	-- Kit
	if createCharScreen:GetCurrentStep() == 6 then
		currentChargenKit = math.random(#chargen.kit)
		createCharScreen:OnKitSelectButtonClick(chargen.kit[currentChargenKit].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Alignment
	if createCharScreen:GetCurrentStep() == 7 then
		createCharScreen:OnMenuButtonClick()
		currentChargenAlignment = math.random(#chargen.alignment)
		createCharScreen:OnAlignmentSelectButtonClick(chargen.alignment[currentChargenAlignment].id)
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end
	
	-- Abilities
	if createCharScreen:GetCurrentStep() == 8 then
		createCharScreen:OnMenuButtonClick()
	end
	
end

function rolled()
	totalAbilities = 0
	for i=1,6,1 do
		storedStats[i] = chargen.ability[i].roll
		totalAbilities = totalAbilities + storedStats[i]
	end
	Infinity_PopMenu()
	createCharScreen:OnDoneButtonClick()
	for i=1,5,1 do
		createCharScreen:OnMainBackButtonClick()
	end

end

function autoroll()
	createCharScreen:OnMenuButtonClick()
	rollFirst = 0
	while chargen.totalRoll ~= totalAbilities do
		createCharScreen:OnAbilityReRollButtonClick()
	end
	
	PointReduction()

	for i=1,6,1 do
		clicktimes = tonumber(storedStats[i]) - tonumber(chargen.ability[i].roll)
		if clicktimes > 0 then 
			for j=1,clicktimes,1 do
				createCharScreen:OnAbilityPlusMinusButtonClick(i,true)
			end
		end
	end
end

function PointReduction()
	local oldPoints
	for i = 1,6,1 do
		oldPoints = chargen.extraAbilityPoints + 1
		while oldPoints ~= chargen.extraAbilityPoints do
			oldPoints = chargen.extraAbilityPoints
			createCharScreen:OnAbilityPlusMinusButtonClick(i,false)						
		end		
	end
	createCharScreen:OnAbilityStoreButtonClick()
end

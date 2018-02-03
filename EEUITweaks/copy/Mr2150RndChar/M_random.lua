function randChar()
	randomCharacter = 1

	-- Gender
	if createCharScreen:GetCurrentStep() == 0 then
		-- Must be named 'gender' and must be called before OnMenuButtonClick for LeUI
		gender = math.random(2)
		createCharScreen:OnMenuButtonClick()
		-- LeUI automatically advance to the next screen
		if createCharScreen:GetCurrentStep() == 0 then
			createCharScreen:OnGenderSelectButtonClick(gender)
			Infinity_PopMenu()
			createCharScreen:OnDoneButtonClick()
		end
	end

	-- Portrait
	if createCharScreen:GetCurrentStep() == 1 then
		while createCharScreen:GetCurrentPortrait() ~= "MAN2L" and createCharScreen:GetCurrentPortrait() ~= "WOMAN2L" do
			createCharScreen:DecCurrentPortrait()
		end
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
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
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
		while chargen.totalRoll < 85 do
			createCharScreen:OnAbilityReRollButtonClick()
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end

	-- Skills
	if createCharScreen:GetCurrentStep() == 9 then
		createCharScreen:OnMenuButtonClick()
		while chargen.extraProficiencySlots > 0 do
			currentChargenProficiency = math.random(#chargen.proficiency)
			createCharScreen:OnProficiencyPlusMinusButtonClick(chargen.proficiency[currentChargenProficiency].id, true)
		end
		while chargen.extraSkillPoints > 0 do
			currentChargenThiefSkill = math.random(#chargen.thief_skill)
			for i=1,5,1 do
				createCharScreen:OnThiefSkillPlusMinusButtonClick(chargen.thief_skill[currentChargenThiefSkill].id, true)
			end
		end
		Infinity_PopMenu()
		createCharScreen:OnDoneButtonClick()
	end

	-- Mage Choose Learned Spells
	while createCharScreen:GetCurrentStep() == 11 do
		for idx, spell in pairs(chargen.choose_spell) do
			if spell.enabled then
				createCharScreen:OnLearnMageSpellButtonClick(idx)
			end
		end
		while chargen.extraSpells > 0 do
			currentChargenChooseMageSpell = math.random(#chargen.choose_spell)
			createCharScreen:OnLearnMageSpellButtonClick(currentChargenChooseMageSpell)
			if chargen.extraSpells == 0 and not createCharScreen:IsDoneButtonClickable() then
				createCharScreen:OnLearnMageSpellButtonClick(currentChargenChooseMageSpell)
			end
		end
		createCharScreen:OnDoneButtonClick()
	end

	-- Mage Choose Active Spells
	while createCharScreen:GetCurrentStep() == 12 do
		while chargen.extraSpells > 0 do
			currentChargenMemorizeMageSpell = math.random(#chargen.choose_spell)
			createCharScreen:OnMemorizeMageSpellButtonClick(currentChargenMemorizeMageSpell, 1)
			if chargen.extraSpells == 0 and not createCharScreen:IsDoneButtonClickable() then
				createCharScreen:OnMemorizeMageSpellButtonClick(currentChargenMemorizeMageSpell, -1)
			end
		end
		createCharScreen:OnDoneButtonClick()
	end

	-- Priest
	while createCharScreen:GetCurrentStep() == 13 do
		while chargen.extraSpells > 0 do
			currentChargenMemorizePriestSpell = math.random(#chargen.choose_spell)
			createCharScreen:OnMemorizePriestSpellButtonClick(currentChargenMemorizePriestSpell, 1)
		end
		createCharScreen:OnDoneButtonClick()
	end

	-- Racial Enemy
	if createCharScreen:GetCurrentStep() == 10 then
		currentChargenHatedRace = math.random(#chargen.hatedRace)
		createCharScreen:OnRacialEnemySelectButtonClick(chargen.hatedRace[currentChargenHatedRace].id)
		createCharScreen:OnDoneButtonClick()
	end
end

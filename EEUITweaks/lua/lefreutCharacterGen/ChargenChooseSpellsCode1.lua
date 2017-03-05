`
function specialistFrame(num)
	if spellBook[chargen.currentSpellLevelChoice][chargen.choose_spell[num].key].specialist then
		return 3
	end
	return 0
end
function specialistOrSelectedFrame(num)
	if chargen.choose_spell[rowNumber].enabled or chargen.choose_spell[rowNumber].known then
		return 2
	end
	return specialistFrame(num)
end

function chooseSpellOrGeneralHelp()
	if needSpecialist then
		return Infinity_FetchString(engine_mode == 0 and 24318 or 33381)
	end
	local spell = chargen.choose_spell[currentChargenChooseMageSpell]
	if spell then
		local desc = spellBook[chargen.currentSpellLevelChoice][spell.key].desc
		if desc ~= -1 then
			return Infinity_FetchString(desc)
		end
	end
	return Infinity_FetchString(engine_mode == 0 and 24314 or 55489)
end

function nextOrDone()
	if(createCharScreen:HasMoreMageLevels()) then
		return t('NEXT_BUTTON')
	else
		return t('DONE_BUTTON')
	end
end
`

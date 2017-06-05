`
function priestMemorizeSpellOrGeneralHelp()
	local spell = chargen.choose_spell[currentChargenMemorizePriestSpell]
	if spell then
		local desc = priestSpells[chargen.currentSpellLevelChoice][spell.key].desc
		if desc ~= -1 then
			return Infinity_FetchString(desc)
		end
	end
	return Infinity_FetchString(17253)
end
function getPriestFrame(cellNum, minus)
	if minus and chargen.choose_spell[cellNum].count > 0 then
		return true
	elseif not minus and chargen.extraSpells > 0 then
		return true
	else
		return false
	end
end
`

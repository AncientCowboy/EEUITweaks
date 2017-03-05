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
`

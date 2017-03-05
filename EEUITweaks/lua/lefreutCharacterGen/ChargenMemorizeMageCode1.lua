`
function mageMemorizeSpellOrGeneralHelp()
	if needSpecialist then
		return Infinity_FetchString(engine_mode == 0 and 24318 or 33381)
	end
	local spell = chargen.choose_spell[currentChargenMemorizeMageSpell]
	if spell then
		local desc = mageSpells[chargen.currentSpellLevelChoice][spell.key].desc
		if desc ~= -1 then
			return Infinity_FetchString(desc)
		end
	end
	return Infinity_FetchString(17253)
end
function spellSelectable(row)
	if row == 1 then
		needSpecialist = false
	end

	local selectable = true
	if chargen.extraSpells == 0 then
		selectable = false
	elseif chargen.extraSpells == 1 then
		createCharScreen:OnMemorizeMageSpellButtonClick(row, 1)
		selectable = createCharScreen:IsDoneButtonClickable()
		createCharScreen:OnMemorizeMageSpellButtonClick(row, -1)
		if not selectable then needSpecialist = true end
	end
	return selectable
end
`

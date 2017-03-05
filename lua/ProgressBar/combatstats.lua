	elseif currentTab == 9 then
		showJustText = 1
		showStats = 0
		helpTextString = ''
		table.insert(listItems, { 'HP_LABEL', characters[currentID].HP.current .. '/' .. characters[currentID].HP.max , characters[currentID].HP.details })
		table.insert(listItems, { 'AC_LABEL', displayCompiledAC(),  characters[currentID].AC.details })
		table.insert(listItems, { 'NUM_ATTACKS_LABEL', characters[currentID].proficiencies.numAttacks.current, '' })
		
		if characters[currentID].proficiencies.weapons.current ~= "" then
			table.insert(listItems, { 'PROFICIENCIES_LABEL', '', characters[currentID].proficiencies.weapons.current })
		end
		if characters[currentID].proficiencies.fightingstyles.current ~= "" then
			table.insert(listItems, { 'FIGHTING_STYLES_LABEL', '', characters[currentID].proficiencies.fightingstyles.current })
		end

		if ( characters[currentID].THAC0.detailsOffhand ~= nil and characters[currentID].THAC0.detailsOffhand ~= "" ) then
			table.insert(listItems, { 'MAIN_HAND_THAC0', characters[currentID].THAC0.current .. '\n' .. characters[currentID].THAC0.details .. '\n\n' .. t('OFF_HAND_THAC0')..': '..characters[currentID].THAC0.offhand .. '\n' .. characters[currentID].THAC0.detailsOffhand,  '' })
		else
			table.insert(listItems, { 'THAC0_LABEL', characters[currentID].THAC0.current,  characters[currentID].THAC0.details })
		end

		if ( characters[currentID].damage.maxOffhand ) then
			table.insert(listItems, { 'MAIN_HAND_DAMAGE', characters[currentID].damage.min .. '-' .. characters[currentID].damage.max .. '\n' .. characters[currentID].damage.details .. '\n\n' .. t('OFF_HAND_DAMAGE') .. ': ' .. characters[currentID].damage.minOffhand .. '-' .. characters[currentID].damage.maxOffhand .. '\n' .. characters[currentID].damage.detailsOffhand, ''})
		else
			table.insert(listItems, { 'DAMAGE_LABEL', characters[currentID].damage.min .. '-' .. characters[currentID].damage.max, characters[currentID].damage.details})
		end
		table.insert(listItems, { 'SAVING_THROWS_LABEL', '',  characters[currentID].proficiencies.savingThrows })
		table.insert(listItems, { 'RESISTANCES_LABEL', '',  characters[currentID].proficiencies.resistances })
		table.insert(listItems, { 'CURRENT_SCRIPT_LABEL', '',  characters[currentID].proficiencies.currentScript })

		for k, v in ipairs(listItems) do				
			if (v[3] == '' or v[3] == nil) then
				helpTextString = helpTextString ..  t(v[1])  .. ': '.. v[2] .. '^-' .. '\n\n'
			else
				helpTextString = helpTextString ..  t(v[1])  .. ': '.. v[2] .. '^-' .. '\n' .. v[3]  ..'\n\n'
			end
		end
	

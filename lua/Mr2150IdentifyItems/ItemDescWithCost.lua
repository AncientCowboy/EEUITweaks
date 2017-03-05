
			if characters[id].gold >= costGold then
				C:AddGold(-costGold)
				Infinity_OnSpellIdentify(characters[id].equipment[selectedSlot].id); 
				itemDesc.item = characters[id].equipment[selectedSlot].item
			else
				Infinity_PlaySound('GAM_47')
			end

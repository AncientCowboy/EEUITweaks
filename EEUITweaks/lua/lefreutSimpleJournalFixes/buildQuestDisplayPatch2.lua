					if(objective.text == Infinity_FetchString(quest.text) or objective.text == nil) then
						objective.text = objective.entries[1].timeStamp
					end
					if(objective.stateType ~= const.ENTRY_TYPE_INFO) then
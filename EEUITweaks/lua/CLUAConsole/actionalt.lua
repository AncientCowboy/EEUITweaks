		actionAlt
		"
			if rgCheat == 0 then
				Infinity_PushMenu('cheatConsole')
				Infinity_PushMenu('cheatMenu')
				rgCheat = 1
			else
				Infinity_PopMenu('cheatConsole')
				Infinity_PopMenu('cheatMenu')
				rgCheat = 0
			end
		"
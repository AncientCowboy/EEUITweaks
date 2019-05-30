`
function getDialogButtonEnabled()
	if(gameOptions.m_bConfirmDialog == true) then
		return true
	else
		return (#worldPlayerDialogChoices == 0)
	end
end

function getDialogButtonClickable()
	if(gameOptions.m_bConfirmDialog == true) then
		return (#worldPlayerDialogChoices == 0) or (worldPlayerDialogSelection and worldPlayerDialogSelection > 2) --no choices, or we've selected a choice.
	else
		return true
	end
end
`

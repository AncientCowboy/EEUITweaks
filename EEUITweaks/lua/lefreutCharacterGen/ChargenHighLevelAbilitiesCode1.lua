`
currentHLASelection = nil
function chargenHLADescription()
	if currentHLASelection == nil then
		return 63817
	end
	return chargen.HLAs[currentHLASelection].description
end
function chargenHLAPlusMinusFrame(minus, cell, rownumber)
	if minus and chargen.HLAs[rownumber].canSubtract then
		return currentCellCheck(cell)
	elseif not minus and chargen.HLAs[rownumber].canAdd then
		return currentCellCheck(cell)
	else
		return 3
	end
end
`

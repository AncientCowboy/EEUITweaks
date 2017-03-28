function childrenContainsChapter(children)
	for k,v in pairs(children) do
		if containsChapter(questDisplay[v].chapters,chapter) then
			return true
		end
	end
	return nil
end
function questEnabled(row)
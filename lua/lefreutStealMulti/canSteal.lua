function canSteal()
	local nb = 0
	for _, v in pairs(store.storeItems) do
		if v.highlight == 1 then
			nb = nb + 1
		end
	end
	return nb > 0 and nb + #store.groupItems <= 16
end

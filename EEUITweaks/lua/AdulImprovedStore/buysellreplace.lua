function storeSplitStack(count)
  if (count ~= 0) then
		storeScreen:SelectStoreItem(storeItemsVar-1, true);
		storeScreen:SetStoreItemCount(storeItemsVar-1, count);
	else
		storeScreen:SelectStoreItem(storeItemsVar-1, false);
	end
end
function groupSplitStack(count)
  if (count ~= 0) then
		storeScreen:SelectGroupItem(storeGroupItemsVar-1, true);
		storeScreen:SetGroupItemCount(storeGroupItemsVar-1, count);
	else
		storeScreen:SelectGroupItem(storeGroupItemsVar-1, false);
	end
end

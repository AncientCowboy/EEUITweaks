
if(uiTranslationFile) then
	Infinity_DoFile(uiTranslationFile .. "PgB.lua")
	if(uiStrings.PGBAR_ENABLE_LABEL == nil) then -- Badly named or non-existent file
		Infinity_DoFile("en_USPgB.lua")
	end
else
	Infinity_DoFile("en_USPgB.lua")
end

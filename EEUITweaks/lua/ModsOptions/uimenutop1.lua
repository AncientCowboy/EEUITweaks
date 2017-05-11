
if(uiTranslationFile) then
	Infinity_DoFile(string.sub(uiTranslationFile,1,3).."ModOp.lua")
	if(uiStrings.MODOPT_TITLE == nil) then
		Infinity_DoFile("en_ModOp.lua")
	end
else
	Infinity_DoFile("en_ModOp.lua")
end

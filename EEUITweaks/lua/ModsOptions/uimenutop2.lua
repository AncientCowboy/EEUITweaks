
if(uiTranslationFile) then
	Infinity_DoFile(string.sub(uiTranslationFile,1,3).."HideO.lua")
	if(uiStrings.MODOPT_TITLE == nil) then
		Infinity_DoFile("en_HideO.lua")
	end
else
	Infinity_DoFile("en_HideO.lua")
end

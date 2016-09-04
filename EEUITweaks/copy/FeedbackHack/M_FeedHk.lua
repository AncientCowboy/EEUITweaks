
if(uiTranslationFile) then
	Infinity_DoFile("L_" .. uiTranslationFile)
	Infinity_DoFile(string.sub(uiTranslationFile,1,3).."FeedH.lua")
	if(uiStrings.FEEDBACK_HACK_EXPAND_TT == nil) then -- Badly named or non-existant file
		Infinity_DoFile("en_FeedH.lua")
	end
else
	Infinity_DoFile("L_en_us")
	Infinity_DoFile("en_FeedH.lua")
end

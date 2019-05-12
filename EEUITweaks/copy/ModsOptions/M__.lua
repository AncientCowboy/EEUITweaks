savedInfinity_DoFile = nil
files = {}

local function wrapper(str)
	savedInfinity_DoFile(str)

	if str:sub(1, 2):upper() == "L_" then
		for _,file in ipairs(files) do
			savedInfinity_DoFile(file)
		end
	end
end

function Infinity_RegisterFile(file)
	if savedInfinity_DoFile == nil then
		savedInfinity_DoFile = Infinity_DoFile
		Infinity_DoFile = wrapper
	end

	table.insert(files, file)
end

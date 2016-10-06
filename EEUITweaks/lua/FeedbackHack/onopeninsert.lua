		local x,y,w,h ;
		x,y,w,h = Infinity_GetArea('PermanentThieving')
		if(x) then
			if(keybindings[2][7][6] ~= 0) then 
				Infinity_SetArea('FBHackUp',x+w-2,nil,nil,nil)
				Infinity_SetArea('FBHackDown',x+w+39,nil,nil,nil)
			else
				Infinity_SetArea('FBHackUp',x-2,nil,nil,nil)
				Infinity_SetArea('FBHackDown',x+39,nil,nil,nil)
			end
		end

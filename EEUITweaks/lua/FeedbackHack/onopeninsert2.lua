		local x,y,w,h ;
		x,y,w,h = Infinity_GetArea('PermanentThieving')
		if(x) then
			if(keybindings[2][7][6] ~= 0) then 
				Infinity_SetArea('FBHackUp',x+w,nil,nil,nil)
				Infinity_SetArea('FBHackDown',x+w+43,nil,nil,nil)
			else
				Infinity_SetArea('FBHackUp',x,nil,nil,nil)
				Infinity_SetArea('FBHackDown',x+43,nil,nil,nil)
			end
		end


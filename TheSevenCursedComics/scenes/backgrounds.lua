local backgrounds = {}

 

backgrounds.newParalax = function(imageName, y, speed)
 
 	local g = display.newGroup()
	
	local ground = display.newImage(imageName, display.contentWidth, display.contentHeight)
	local ground2 = display.newImage(imageName, display.contentWidth, display.contentHeight)
	
	ground.x=0
	ground.y=y
	ground2.y=y	
	ground2.x=ground.x+ground.width

	local function moveBackground()
		if (ground2.x==0) then
			ground.x=ground.width
		end
		
		if (ground.x==0) then
			ground2.x=ground.width
		end
		
		ground2.x=ground2.x-speed
		ground.x=ground.x-speed
		
	end

	
	
	g:insert(ground)
	g:insert(ground2)
	
	Runtime:addEventListener( "enterFrame", moveBackground )
	
	
	return g
end

return backgrounds
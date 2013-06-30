local backgrounds = {}

 

backgrounds.newParalax = function(imageName,  y, speed)
 
	
 	local g = display.newGroup()
	
	local ground = display.newImage(imageName, display.contentWidth, display.contentHeight)
	local ground2 = display.newImage(imageName, display.contentWidth, display.contentHeight)
	
	ground.x=display.screenOriginX+display.contentWidth/2
	ground.y=y
	
	ground2.y=y
	ground2.x=display.contentWidth+ground.x

	local initX = ground2.x

	local function moveBackground()		
	 
		if(ground.x <= -display.contentWidth/2) then
			ground.x = initX
		end
		
		if(ground2.x <= -display.contentWidth/2) then
			ground2.x = initX
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
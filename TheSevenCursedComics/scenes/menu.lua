----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
local function onPlay(event)
	if event.phase == "began" then
		game:transitionTo("storyP1", "slideDown", 1000)
	end
end

local function onOptions(event)
	if event.phase == "began" then
		game:transitionTo("options", "slideLeft", 1000)
	end
end

local function onLevel1(event)
	if event.phase == "began" then
		game:transitionTo("boss", "crossFade", 500)
	end
end

local function onLevel2(event)
	if event.phase == "began" then
		game:transitionTo("levelT", "crossFade", 500)
	end
end


----------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local play, options, buttonWidth, buttonHeight, buttonWidthO, buttonHeightO
	
	buttonWidth = 212
	buttonHeight = 89
	
	buttonWidthO = 348
	buttonHeightO = 89
	
	local background = display.newImage("assets/images/backgrounds/portrait.png",0,0, display.contentWidth, display.contentHeight)
	background:toBack()
	group:insert(background)
	
	play = display.newRect(87, 422,buttonWidth,buttonHeight)
	options = display.newRect(308, 422, buttonWidthO, buttonHeightO)
	local level1 =  display.newRect(87, 565,179,46)
	local level2 =  display.newRect(356, 565,179,46)
	
	play.alpha = 0.01
	options.alpha = 0.01
	level1.alpha=0.01
	level2.alpha=0.01
		
	play:addEventListener("touch", onPlay)
	options:addEventListener("touch", onOptions)
	level1:addEventListener("touch", onLevel1)
	level2:addEventListener("touch", onLevel2)
	
	
	group:insert(play)
	group:insert(options)
	group:insert(level1)
	group:insert(level2)

end
scene:addEventListener( "createScene", scene )

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	storyboard.purgeAll()
end
scene:addEventListener( "enterScene", scene )

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
end
scene:addEventListener( "exitScene", scene )

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
end
scene:addEventListener( "destroyScene", scene )


return scene
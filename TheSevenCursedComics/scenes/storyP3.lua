----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local dialogs = require("game.dialogs")
----------------------------------------------------------------------------------
local function onTouch(event)
	if event.phase == "began" then
		Runtime:removeEventListener("touch", onTouch)
		game:transitionTo("storyP4", "crossFade", 2000)
	end
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local path = "assets/images/backgrounds/"
	local box
	local text, text2
	
	box = display.newImageRect(path.."box.jpg", display.contentWidth, display.contentHeight)
	box.x = (box.width / 2); box.y = (box.height / 2)
		
	text = display.newText(dialogs["storyP3"](), 5, display.contentHeight, display.contentWidth - 10, display.contentHeight , game:getFont(), 20)
	text:setTextColor(255,255,0)
	transition.to( text, { time=5000, y = display.contentHeight / 0.88} )
	
	text2 = display.newText(dialogs["storyP3"](), 6, display.contentHeight +2, display.contentWidth - 10, display.contentHeight , game:getFont(), 20)
	text2:setTextColor(0,0,0)
	transition.to( text2, { time=5000, y = display.contentHeight / 0.88} )
	
	group:insert(box)
	group:insert(text2)
	group:insert(text)
end
scene:addEventListener( "createScene", scene )


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	Runtime:addEventListener("touch", onTouch)
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
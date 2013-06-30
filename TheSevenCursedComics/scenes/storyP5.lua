----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local dialogs = require("game.dialogs")
----------------------------------------------------------------------------------
local function onTouch(event)
	if event.phase == "began" then
		Runtime:removeEventListener("touch", onTouch)
		audio.stop({channel=1})
		audio.stop({channel=2})
		game:transitionTo("levelT", "crossFade", 2000)
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local path = "assets/images/backgrounds/"
	local fall

	fall = display.newImageRect(path.."fall.jpg", display.contentWidth, display.contentHeight)
	fall.x = (fall.width / 2); fall.y = (fall.height / 2)
		
	group:insert(fall)
	
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
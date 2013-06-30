----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local player = require("game.player")
local scene = storyboard.newScene()
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local pSprite = player:loadPlayer(100,300, 50, 75)
	
	
	local physics = require "physics"		
	physics.start()
	physics.setDrawMode("normal")	
	
	game:setPlayer(pSprite)
    group:insert(pSprite)
	group:insert(game:loadUI())
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
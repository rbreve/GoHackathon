----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------
local sprite = require("sprite")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local paralax = require "scenes.backgrounds"
local monster = require "scenes.monster"
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	local sdata = monster.getSpriteSheetData()
	local spriteSheet = sprite.newSpriteSheetFromData( "monster1.png", sdata )

	
	local bg = display.newRect(-50,0,1000,500)
	bg:setFillColor(16,198,232)

	local ground  = paralax.newParalax("images/ground.png", 280, 10)
	local clouds = paralax.newParalax("images/clouds.png", 150, 1)
	local mountains = paralax.newParalax("images/mountains1.png", 200, 4)
	
	
	group:insert(bg)
	group:insert(clouds)
	group:insert(mountains)
	group:insert(ground)
	
	
end


scene:addEventListener( "createScene", scene )


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
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
	Runtime:addEventListener( "enterFrame", moveBackground )
	
	
end
scene:addEventListener( "destroyScene", scene )


return scene

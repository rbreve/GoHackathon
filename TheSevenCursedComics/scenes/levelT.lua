----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local player = require("game.player")
local prefabs = require("game.prefabs")
local scene = storyboard.newScene()
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	game:setGroup(group)
	prefabs:createBackground(200,200,255)
	
	local pSprite = player:loadPlayer(100,300, 50, 75)
	
	local physics = require "physics"	
	game:setPhysics(physics)
	physics.start()
	physics.setGravity(0, 52)
	physics.setDrawMode("normal")	
	
	--Level Design
	prefabs:createClouds(100,100, 1)
	prefabs:createPlatform(100,420, 1)
	prefabs:createPlatform(100,600, 1)
	prefabs:createPlatform(300,400, 2)
	prefabs:createPlatform(300,540, 2)
	prefabs:createPlatform(450,350, 1)
	prefabs:createPlatform(450,540, 1)
	prefabs:createPlatform(700,500, 2)
	prefabs:createPlatform(700,650, 2)
	prefabs:createPlatform(850,400, 2)
	prefabs:createPlatform(850,530, 2)
	prefabs:createDoor(1024,200, "level1")
	--Level Design
	playBackgroundMusic("Hustle.mp3")
	
	game:setState("normal")
	game:setScene("levelT")
	game:setPlayer(pSprite)
    group:insert(pSprite)
end
scene:addEventListener( "createScene", scene )


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	group:insert(game:loadUI())
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
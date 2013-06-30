----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local player = require("game.player")
local prefabs = require("game.prefabs")
local dialogs = require("game.dialogs")
local scene = storyboard.newScene()
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	game:setGroup(group)
	prefabs:createBackground(16,198,232)
	
	local pSprite = player:loadPlayer(75,450, 50, 75)
	
	local physics = require "physics"	
	game:setPhysics(physics)
	physics.start()
	physics.setGravity(0, 90)
	physics.setDrawMode("normal")	
	
	--Level Design
	prefabs:createClouds(100,100, 1)
	prefabs:createMountains(0,490, 55,1111)
	prefabs:createPlatform(-90,display.contentHeight - 50, 1)
	prefabs:createPlatform(-90,display.contentHeight - 150, 1)
	prefabs:createPlatform(-90,display.contentHeight - 250, 1)
	prefabs:createPlatform(-90,display.contentHeight - 350, 1)
	prefabs:createPlatform(-90,display.contentHeight - 450, 1)
	prefabs:createPlatform(-90,display.contentHeight - 550, 1)
	
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 50, 1)
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 150, 1)
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 250, 1)
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 350, 1)
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 450, 1)
	prefabs:createPlatform(display.contentWidth - 20,display.contentHeight - 550, 1)
	
	prefabs:createPlatform(0,display.contentHeight - 100, 3)
	
	prefabs:createDoor(1024,200, "menu")
	playBackgroundMusic("Hustle.mp3")
	--Level Design
	game:setPlayer(pSprite)
	prefabs:createBurger(780,328, 500)
	--Level Design
	
	local text = display.newText(dialogs["feedMe"](), 10, 110, display.contentWidth - 10, display.contentHeight , game:getFont(), game:getFontSize())
	text:setTextColor(255,255,0)
	text.alpha = 0
	transition.to( text, { time=500, alpha = 1} )
	
	local text2 = display.newText(dialogs["feedMe"](), 11, 108, display.contentWidth - 10, display.contentHeight , game:getFont(), game:getFontSize())
	text2:setTextColor(0,0,0)
	text2.alpha = 0
	transition.to( text2, { time=500, alpha = 1} )
	
	game:setScene("level3")
    group:insert(pSprite)
	group:insert(text)
	group:insert(text2)
	
	local v = function()
		transition.to( text, { time=500, alpha = 0} )
		transition.to( text2, { time=500, alpha = 0} )
	end
	
	timer.performWithDelay(7000, v)
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
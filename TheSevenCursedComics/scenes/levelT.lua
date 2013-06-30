----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local player = require("game.player")
local scene = storyboard.newScene()
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local pSprite = player:loadPlayer(250,300, 50, 75)
	
	
	local physics = require "physics"	
	game:setPhysics(physics)
	physics.start()
	physics.setGravity(0, 40)
	physics.setDrawMode("normal")	
	
	local background = display.newRect(0,0, display.contentWidth, display.contentHeight)
	background:setFillColor(200,200,255)
	background:toBack()
	group:insert(background)
	
		
	local rect = display.newRect(0,500,display.contentWidth, 100)
	rect:setFillColor(50,0,0)
	physics.addBody(rect, "static", {friction = 0.1 })
	
	rect.myName = "ground"
	
	local rect2 = display.newRect(450,0,50, 50)
	rect2:setFillColor(50,0,0)
	physics.addBody(rect2, {bounce=0.2})
	
	rect2.myName = "enemy"
	
	local rect3 = display.newRect(100,0,50, 50)
	rect3:setFillColor(0,50,0)
	physics.addBody(rect3, {bounce=0.2})
	
	rect3.myName = "food"
	
	group:insert(rect)
	group:insert(rect2)
	group:insert(rect3)
	
	game:setState("normal")
	game:setScene("levelT")
	game:setGroup(group)
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
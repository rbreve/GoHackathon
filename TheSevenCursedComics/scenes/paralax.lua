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
local player = require("game.player")
local enemy = require("game.enemy1")
----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local pSprite = player:loadPlayer(100,300, 50, 75)
	
    group:insert(pSprite)

		
	local bg = display.newRect(0,0,display.contentWidth,700)
	bg:setFillColor(16,198,232)

	local ground  = paralax.newParalax("images/ground.png", 610, 10)
	local clouds = paralax.newParalax("images/clouds.png", 150, 1)
	local mountains = paralax.newParalax("images/mountains1.png", 530, 4)
	local enemy = enemy:loadPlayer(200,300, 50, 75)
	
	
	--			local scaleFactor = 1.0
	--			local physicsData = (require "shapedefs").physicsData(scaleFactor)
	--			local shape = display.newImage("objectname.png")
	--			physics.addBody( shape, physicsData:get("objectname") )
	
	local physicsData = (require "assets.images.objects.blue_gumS").physicsData(1)
	local ball = display.newImage("assets/images/objects/blue_gumS.png")
	physics.addBody( ball, physicsData:get("blue_gumS") )
	
	ball.isFixedRotation=false
	ball.x=1300
	ball.y=300
	ball:applyForce(-4000,2000,ball.x-10, ball.y-10)
	

	
	local ground=display.newRect(0,560,display.contentWidth, display.contentHeight)
	physics.addBody(ground,"static" ,{  density=1, friction=0.3 , bounce=0.4 })
	
	
	group:insert(bg)
	group:insert(clouds)
	group:insert(mountains)
	group:insert(ground)
	group:insert(enemy)
	group:insert(ball)
	
	
	local moveY=3
	
	function moveEnemy()
		
		enemy.y=enemy.y+moveY
		
		if (enemy.y>350 and moveY>0) then
			moveY=-moveY
		else if (enemy.y<250 and moveY<0) then
			moveY=-moveY
		end
		end
		
	end
	
	Runtime:addEventListener( "enterFrame", moveEnemy )
	
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
	Runtime:removeEventListener( "enterFrame", moveBackground )
	Runtime:removeEventListener( "enterFrame", moveEnemy )
	
	
end
scene:addEventListener( "destroyScene", scene )


return scene

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
local physics = require("physics")

----------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	
	local confites = {}
	
	game:setPhysics(physics)
	physics.start()
	physics.setGravity(0, 40)
	physics.setDrawMode("normal")
	
	
	local group = self.view
	
	game:setGroup(group)
	
	local pSprite = player:loadPlayer(100,300, 50, 75)
	
    group:insert(pSprite)


		
	
	local bg = display.newRect(0,0,display.contentWidth,700)
	bg:setFillColor(16,198,232)

	local ground  = paralax.newParalax("images/ground.png", 610, 10)
	
	local clouds = paralax.newParalax("images/clouds.png", 150, 1)
	local mountains = paralax.newParalax("images/mountains1.png", 530, 4)
	
	local enemy = enemy:loadPlayer(100,300, 50, 75)
	local enemyInc=1
	
	
	local dude = player.loadPlayer(400,600)
	
	--			local scaleFactor = 1.0
	--			local physicsData = (require "shapedefs").physicsData(scaleFactor)
	--			local shape = display.newImage("objectname.png")
	--			physics.addBody( shape, physicsData:get("objectname") )
	
	
	
	-- --------- door
	local options = {
	   width = 136,
	   height = 309,
	   numFrames = 2
	}
	
	local doorSheet = graphics.newImageSheet("assets/images/objects/exit_door.png", options)
	local doorSprite
	local sequenceData = {
	   { name = "door", start=1, count=2, time=500,   loopCount=9999 }
	}
	
	doorSprite = display.newSprite(doorSheet, sequenceData)
	doorSprite:setSequence("door")
	doorSprite:play()
	doorSprite.myName = "door"
	doorSprite.x = 3500; doorSprite.y = 400
	game:setNextScene("paralax")

	local physics = game:getPhysics()
	physics.addBody(doorSprite, "static")
	
	local groundPhysics=display.newRect(0,560,display.contentWidth*2, display.contentHeight)
	physics.addBody(groundPhysics,"static" ,{  density=1, friction=0.3 , bounce=0.4 })
	groundPhysics.myName="ground"
	
	game:setState("normal")
	
	group:insert(groundPhysics)
	
	
	group:insert(bg)
	group:insert(clouds)
	group:insert(mountains)
	group:insert(enemy)
	
	game:setPlayer(dude)
	
	group:insert(dude)
	group:insert(ground)
	
	group:insert(game:loadUI())
	group:insert(doorSprite)
	
	game:setScene("levelT")
	
	local moveY=3
	
	function moveEnemy()
		
		
		paralax.setMoving(game:isMoving())
		
		if (game:isMoving()) then
			doorSprite.x = doorSprite.x-9
			
			for i = 1, #confites do
				if(confites[i].x~=nil) then
					confites[i].x=confites[i].x-9
				end
			end
		end
		
		if(enemy.y~=nil) then
			enemy.y=enemy.y+moveY
			
			enemy.x=enemy.x+enemyInc
			
			if(game:isMoving()) then
				enemy.x=enemy.x-2
			end
		
			if (enemy.y>350 and moveY>0) then
				moveY=-moveY
			else if (enemy.y<250 and moveY<0) then
				moveY=-moveY
			end
			end
		end
		 
	end
	
	function onLocalCollision(self,event)
		if(event.phase=="began") then
			if(event.other.myName=="player") then
				self:removeSelf()
				game.eatFood()
				enemyInc=enemyInc+1
			end
		end
	end
	
	function addConfite(x,y)
		
	
		
		local color=math.random(1,3)
		local colorName="blue"
		
		if (color==2) then
			colorName="pink"
		end
		
		
		if (color==3) then
			colorName="yellow"
		end
		
		local physicsData = (require "assets.images.objects.blue_gumS").physicsData(1)
		local ball = display.newImage("assets/images/objects/"..colorName.."_gumS.png")
		physics.addBody( ball, "static", physicsData:get("blue_gumS") )
		ball.isFixedRotation=false
		ball.x=x
		ball.y=y
		ball.collision=onLocalCollision
		ball:addEventListener("collision", ball)
		--ball:applyForce(-3000,2000,ball.x-10, ball.y-10)
		
		table.insert(confites,ball)
		
		group:insert(ball)
		
	end
	
	
	addConfite(1500,520)
	
	addConfite(2000,440)
	
	addConfite(2400,300)
	
	
	Runtime:addEventListener( "enterFrame", moveEnemy )
	--timer.performWithDelay( 2000, dropBall, 20 )
	game.setIsParalax(true)
	
	
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
	Runtime:removeEventListener( "enterFrame", moveBackground )
	
	
end
scene:addEventListener( "destroyScene", scene )


return scene

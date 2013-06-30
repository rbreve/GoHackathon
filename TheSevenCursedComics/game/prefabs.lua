----------------------------------------------------------------------------------
local prefabs = {}
local path = "assets/images/objects/"
----------------------------------------------------------------------------------
function prefabs:createBackground(r, g, b)
	local background = display.newRect(0,0, display.contentWidth, display.contentHeight)
	background:setFillColor(r, g, b)
	background:toBack()
	local group = game:getGroup()
	group:insert(background)
end

function prefabs:createPlatform(x, y, id)
	local platform = display.newImage(path.."platform"..id..".png", x, y)
	platform.myName = "ground"
	
	local p = function()
		local physics = game:getPhysics()
		physics.addBody(platform, "static",{ bounce = 0, friction = 0.1})
	end
	timer.performWithDelay(50, p) 
	--physics.addBody(platform, "static", { bounce = 0, friction = 0.1 })

	local group = game:getGroup()
	group:insert(platform)
end

function prefabs:createClouds(x, y, id)
	local clouds = {}
	clouds[1] = display.newImage(path.."clouds"..id..".png", x, y)
	clouds[2] = display.newImage(path.."clouds"..id..".png", x + clouds[1].width, y)
	
	local movement = function()
	    local state = game:getState()
		
		if state == "normal" and clouds[1].x ~= nil then
		
			clouds[1].x = clouds[1].x - 1
			clouds[2].x = clouds[2].x - 1
				
			if clouds[1].x <= 0 then
				clouds[1].x = clouds[2].x + clouds[2].width
			end
				
			if clouds[2].x <= 0 then
				clouds[2].x = clouds[1].x + clouds[1].width
			end
		else
		if t then
			timer.cancel( t )
		end
		end
	end
	
	local t = timer.performWithDelay( 10, movement, 99999 )
	
	local group = game:getGroup()
	group:insert(clouds[1])
	group:insert(clouds[2])
	
	return clouds
end

function prefabs:createMountains(x, y)
	local mountains =  display.newImage(path.."mountains_hamburger_world.png", x, y)
	local group = game:getGroup()
	group:insert(mountains)
end

function prefabs:createDoor(x, y, nextScene)
	local options = {
	   width = 136,
	   height = 309,
	   numFrames = 2
	}
	local doorSheet = graphics.newImageSheet(path.."exit_door.png", options)
	local doorSprite
	local sequenceData = {
	   { name = "door", start=1, count=2, time=500,   loopCount=9999 }
	}
	
	doorSprite = display.newSprite(doorSheet, sequenceData)
	doorSprite:setSequence("door")
	doorSprite:play()
	
	doorSprite.myName = "door"
	doorSprite.x = x; doorSprite.y = y
	game:setNextScene(nextScene)
	
	local p = function()
		local physics = game:getPhysics()
		physics.addBody(doorSprite, "static",{ bounce = 0})
	end
	timer.performWithDelay(50, p) 
	local group = game:getGroup()
	group:insert(doorSprite)
	
	return doorSprite
end

function prefabs:createChocolateBat(x, y, hp)
	local options = {
	   width = 152,
	   height = 73,
	   numFrames = 2
	}
	local enemySheet = graphics.newImageSheet("assets/images/enemies/chocolate_bat.png", options)
	local enemySprite
	local sequenceData = {
	   { name = "fly", start=1, count=2, time=400,   loopCount=9999 }
	}
	
	enemySprite = display.newSprite(enemySheet, sequenceData)
	enemySprite:setSequence("fly")
	enemySprite:play()
	
	enemySprite.myName = hp
	enemySprite.x = x; enemySprite.y = y
	
	local p = function()
		local physics = game:getPhysics()
		physics.addBody(enemySprite, "kinematic")
	end
	timer.performWithDelay(50, p) 
	
	local group = game:getGroup()
	group:insert(enemySprite)
	
	local player = game:getPlayer()
	local t
	
	local IA = function()
	local state = game:getState()
	
	if state == "normal"  and enemySprite ~= nil then
		if enemySprite.alpha > 0 and enemySprite then
			if player.x - 5 < enemySprite.x then
				enemySprite.x = enemySprite.x - 2
			elseif player.x + 5 > enemySprite.x then
				enemySprite.x = enemySprite.x + 2
			end
		else
			timer.cancel( t )
			enemySprite:removeSelf()
		end
	end
	end
	
	t = timer.performWithDelay( 10, IA, 99999 )
end

function prefabs:createBurger(x, y, hp)
	local options = {
	   width = 228,
	   height = 426,
	   numFrames = 5
	}
	local enemySheet = graphics.newImageSheet("assets/images/enemies/final_hambert.png", options)
	local enemySprite
	local sequenceData = {
	   { name = "eat", start=1, count=5, time=400,   loopCount=9999 }
	}
	
	enemySprite = display.newSprite(enemySheet, sequenceData)
	enemySprite:setSequence("eat")
	enemySprite:play()
	
	enemySprite.myName = hp
	enemySprite.x = x; enemySprite.y = y
	
	local p = function()
		local physics = game:getPhysics()
		physics.addBody(enemySprite, "kinematic")
	end
	timer.performWithDelay(50, p) 
	
	local group = game:getGroup()
	group:insert(enemySprite)
	
	local player = game:getPlayer()
	local t
	
	local IA = function()
	local state = game:getState()
	
	if state == "normal"  and enemySprite ~= nil then
		if enemySprite.alpha > 0 then
		
		else
			timer.cancel( t )
			enemySprite:removeSelf()
		end
	end
	end
	
	t = timer.performWithDelay( 10, IA, 99999 )
end

return prefabs
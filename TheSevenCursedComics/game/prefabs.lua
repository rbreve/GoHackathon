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
	local clouds = display.newImage(path.."clouds"..id..".png", x, y)

	local group = game:getGroup()
	group:insert(clouds)
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

return prefabs
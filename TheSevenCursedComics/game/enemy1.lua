----------------------------------------------------------------------------------
--player.lua
----------------------------------------------------------------------------------
local player = {}

function player:loadPlayer(x, y, width, height)
	local options = {
	   width = 300,
	   height = 300,
	   numFrames = 2
	}
	local playerSheet = graphics.newImageSheet("assets/images/enemy/gumgum.png", options)
	local playerSprite
	local sequenceData = {
	   { name = "stand", start=1, count=1, time=0,   loopCount=1 },
	   { name = "walk", start=1, count=2, time=200,   loopCount=9999 }
	}
	
	playerSprite = display.newSprite(playerSheet, sequenceData)
	playerSprite:setSequence("walk")
	playerSprite:play()
	
	physics.addBody(playerSprite, "static", {bounce=0.2})
	playerSprite.myName="enemy"
	playerSprite.isFixedRotation = true
	playerSprite.x = x; playerSprite.y = y
	playerSprite.width = width; playerSprite.height = height
	
	physics.start()
	physics.setDrawMode("normal")
	return playerSprite
end

return player
----------------------------------------------------------------------------------
--player.lua
----------------------------------------------------------------------------------
local physics = require("physics")
local player = {}

function player:loadPlayer(x, y, width, height)
	local options = {
	   width = 94,
	   height = 181,
	   numFrames = 2
	}
	local playerSheet = graphics.newImageSheet("assets/images/character/player.png", options)
	local playerSprite
	local sequenceData = {
	   { name = "stand", start=1, count=1, time=0,   loopCount=1 },
	   { name = "walk", start=1, count=2, time=200,   loopCount=9999 }
	}
	
	playerSprite = display.newSprite(playerSheet, sequenceData)
	playerSprite:setSequence("stand")
	playerSprite:play()
	
	physics.addBody(playerSprite, "dynamic", {bounce=0.2, shape = { -50,0, 50,0, 50,24, -50,24 }})
	playerSprite.isFixedRotation = true
	playerSprite.x = x; playerSprite.y = y
	playerSprite.width = width; playerSprite.height = height
	
	physics.start()
	physics.setDrawMode("hybrid")
	return playerSprite
end

return player
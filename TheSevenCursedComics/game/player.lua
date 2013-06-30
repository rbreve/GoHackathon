----------------------------------------------------------------------------------
--player.lua
----------------------------------------------------------------------------------
local player = {}

function player:loadPlayer(x, y, width, height)
	local options = {
	   width = 92,
	   height = 215,
	   numFrames = 9
	}
	local playerSheet = graphics.newImageSheet("assets/images/character/player.png", options)
	local playerSprite
	local sequenceData = {
	   { name = "stand", start=1, count=1, time=0,   loopCount=1 },
	   { name = "walk", start=2, count=4, time=400,   loopCount=400 },
	   { name = "jump", start=9, count=1, time=0,   loopCount=1 }
	}
	
	playerSprite = display.newSprite(playerSheet, sequenceData)
	playerSprite:setSequence("stand")
	playerSprite:play()
	
	playerSprite.x = x; playerSprite.y = y
	playerSprite.width = width; playerSprite.height = height

	return playerSprite
end

return player
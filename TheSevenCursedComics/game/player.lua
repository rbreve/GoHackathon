----------------------------------------------------------------------------------
--player.lua
----------------------------------------------------------------------------------
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
	
	playerSprite.x = x; playerSprite.y = y
	playerSprite.width = width; playerSprite.height = height

	return playerSprite
end

return player
local storyboard = require( "storyboard" )
----------------------------------------------------------------------------------
local lives
local state
local isMusicActive_, isSoundActive_ = true, true
local game = {}
local font = "Free Pixel"
local player
----------------------------------------------------------------------------------
function game:transitionTo(sceneName, effectT, timeT)
	--slideLeft (pushes original scene)
	--slideRight (pushes original scene)
	--slideDown (pushes original scene)
	--slideUp (pushes original scene)
	
	local options =
	{
		effect = effectT,
		time = timeT,
	}
	
	storyboard.gotoScene("scenes."..sceneName, options)
end

function game:gameOnUpdate()
	if state == "cutScene" then
	
	end
end

function game:isSoundActive()
	return isSoundActive_
end

function game:isMusicActive()
	return isMusicActive_
end

function game:setSound(bool)
	isSoundActive_ = bool
end

function game:setMusic(bool)
	isMusicActive_ = bool
end

function game:getFont()
	return font
end

function game:onUpdate(event)
	if state == "normal" then
	
	end
	
	if state == "cutScene" then
	
	end
	
	if state == "pause" then
	
	end
	
	if state == "dead" then
	
	end
end

function game:playerBehaviour(self, event)
	
end

function game:setPlayer(pl)
	player = pl
end

return game
----------------------------------------------------------------------------------
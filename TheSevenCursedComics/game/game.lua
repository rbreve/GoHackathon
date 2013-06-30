local storyboard = require( "storyboard" )
----------------------------------------------------------------------------------
local lives
local state
local isMusicActive_, isSoundActive_ = true, true
local isJumping = false
local game = {}
local font = "Free Pixel"
local player
local speed = 250
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

function playerBehaviour(self, event)
	if event.phase == "began" then
		if self.myName == "left" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(-speed, vy)
			player:setSequence("walk")
			player:play()
		end	
		
		if self.myName == "right" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(speed, vy)
			player:setSequence("walk")
			player:play()
		end	
		
		if self.myName == "b" then
			local vx, vy = player:getLinearVelocity()
			
			if not isJumping then
				player:applyLinearImpulse( 0, -1.5, player.x, player.y )
				isJumping = true
			end
			--player:setSequence("stand")
			--player:play()
		end	
		
				
		if self.myName == "a" then
			
		end	
	end
	
	if event.phase == "ended" then
		if self.myName == "left" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
			player:setSequence("stand")
			player:play()
		end	
		
		if self.myName == "right" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
			player:setSequence("stand")
			player:play()
		end
	end
end

function onCollisionPlayer(event)
	if event.phase == "began" then 
		isJumping = false
	end
end

function game:setPlayer(pl)
	player = pl
	physics.addBody(player, {bounce=0, shape = { -50,-100, 50,-100, 50,90, -50,90 }})
	player.isFixedRotation = true
	
	player:addEventListener("collision", onCollisionPlayer)
	
	--[[local rect = display.newRect(0,600,display.contentWidth, 100)
	rect:setFillColor(50,0,0)
	rect:toBack()
	physics.addBody(rect, "static", {friction = 0.1 })
	
	local rect2 = display.newRect(300,0,50, 50)
	rect2:setFillColor(50,0,0)
	rect2:toFront()
	physics.addBody(rect2, {bounce=0.2})]]
	--player:setSequence("walk")
	--player:play()
end

function game:loadUI()
	local group = display.newGroup()
	
	local lPad, rPad, sButton, jButton
	local path = "assets/images/ui/"
	
	lpad = display.newImage(path.."lpad.png", 90, display.contentHeight - 30, 100,75)
	lpad.myName = "left"
	rpad = display.newImage(path.."rpad.png", 310, display.contentHeight - 30, 100,75)	
	rpad.myName = "right"
	
	sButton = display.newImage(path.."abutton.png", 800, display.contentHeight - 30, 75,75)
	sButton.myName = "a"
	jButton = display.newImage(path.."bbutton.png", 950, display.contentHeight - 30, 75,75)	
	jButton.myName = "b"
	
	lpad.touch = playerBehaviour
	rpad.touch = playerBehaviour
	sButton.touch = playerBehaviour
	jButton.touch = playerBehaviour
	
	lpad:addEventListener("touch", lpad)
	rpad:addEventListener("touch", rpad)
	sButton:addEventListener("touch", sButton)
	jButton:addEventListener("touch", jButton)
	
	lpad:toFront()
	rpad:toFront()
	sButton:toFront()
	jButton:toFront()
	
	group:insert(lpad)
	group:insert(rpad)
	return group
end


return game
----------------------------------------------------------------------------------
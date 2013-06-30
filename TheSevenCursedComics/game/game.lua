local storyboard = require( "storyboard" )
----------------------------------------------------------------------------------
local lives, gluttony, hp = 1, 0, 4
local state
local isMusicActive_, isSoundActive_ = true, true
local isJumping = false
local game = {}
local font = "Free Pixel"
local player, group, gl, lPad, rPad, sButton, jButton, hpB
local speed = 250
local currentScene
local hpSound, glSound
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

function game:resetScene()
	game:transitionTo("dummyScene", "crossFade", 500)
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

function game:getFontSize()
	return 45
end

function game:loadResources()
	hpSound =  audio.loadSound("assets/sounds/damageMikeKoenig.mp3")
	glSound = nil
end

function game:onUpdate(event)
	if state == "normal" then
		physics.start()
	end
	
	if state == "cutScene" then
	
	end
	
	if state == "pause" then
		physics.pause()
	end
	
	if state == "dead" then
	
	end
end

function playerBehaviour(self, event)
	if event.phase == "began"  and state == "normal" then
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
				player:applyLinearImpulse( 0, -4, player.x, player.y )
				isJumping = true
			end
			--player:setSequence("stand")
			--player:play()
		end	
		
				
		if self.myName == "a" then
			
		end	
	end
	
	if event.phase == "ended" and state == "normal" then
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
	if event.phase == "began" and state == "normal" then 
		if event.other.myName == "ground" then
			isJumping = false
		end
		
		if event.other.myName == "enemy" then
			playPlayerDamageSound()
			addDamage(1)
		end	
		
		if event.other.myName == "food" then
			playPlayerGLSound()
			addGul(1)
		end	
	end
end

function game:setPlayer(pl)
	player = pl
	physics.addBody(player, {bounce=0, shape = { -50,-100, 50,-100, 50,90, -50,90 }})
	player.isFixedRotation = true
	
	isJumping = false
	
	player:addEventListener("collision", onCollisionPlayer)
	--player:setSequence("walk")
	--player:play()
end

function game:setGroup(gr)
	group = gr
end

function game:setScene(sc)
	currentScene = sc
end

function game:getScene()
	return currentScene
end

function game:setState(tx)
	state = tx
end

function game:loadUI()
	local group = display.newGroup()

	local path = "assets/images/ui/"
	
	lpad = display.newImage(path.."lpad.png", 90, display.contentHeight - 100, 100,75)
	lpad.myName = "left"
	rpad = display.newImage(path.."rpad.png", 310, display.contentHeight - 100, 100,75)	
	rpad.myName = "right"
	
	sButton = display.newImage(path.."abutton.png", 800, display.contentHeight - 100, 75,75)
	sButton.myName = "a"
	jButton = display.newImage(path.."bbutton.png", 950, display.contentHeight - 100, 75,75)	
	jButton.myName = "b"
	
	gl = display.newImage(path.."gluttony"..gluttony..".png", 20, 20)
	hpB = display.newImage(path.."power"..hp..".png", 450, 20)
	
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
	gl:toFront()
	hpB:toFront()
	
	group:insert(lpad)
	group:insert(rpad)
	group:insert(sButton)
	group:insert(jButton)
	group:insert(gl)
	group:insert(hpB)
	
	return group
end

function addGul(value)
	local path = "assets/images/ui/"
	
		gl:removeSelf()
		gl = display.newImage(path.."gluttony"..gluttony..".png", 20, 20)
		gl:toFront()
		group:insert(gl)
			
	gluttony = gluttony + value
		if gluttony >= 4 then
			gluttony = 4
			
			player:removeEventListener("collision", onCollisionPlayer)
			lpad:removeEventListener("touch", lpad)
			rpad:removeEventListener("touch", rpad)
			sButton:removeEventListener("touch", sButton)
			jButton:removeEventListener("touch", jButton)
			
			if lives == 1 then
				lives = lives - 1
				gameOver()
			else			
				lives = lives - 1
				gluttony = 0
				game:resetScene()
			end
		end
end

function addDamage(value)
	local path = "assets/images/ui/"
	
	hp = hp - value
		hpB:removeSelf()
		hpB = display.newImage(path.."power"..hp..".png", 450, 20)
		hpB:toFront()
		group:insert(hpB)
			
		if hp <= 0 then
			hp = 0
			
			player:removeEventListener("collision", onCollisionPlayer)
			lpad:removeEventListener("touch", lpad)
			rpad:removeEventListener("touch", rpad)
			sButton:removeEventListener("touch", sButton)
			jButton:removeEventListener("touch", jButton)
			
			if lives == 1 then
				lives = lives - 1
				gameOver()
			else			
				lives = lives - 1
				hp = 4
				game:resetScene()
			end
		end
end

function gameOver()
	local tx = display.newText("GameOver", (display.contentWidth / 2) - 100,100, game:getFont(), 30)
	--reset stats
	gluttony = 0
	hp = 4
	lives = 1
	
	game:transitionTo("menu", zoomInOutFade, 2000)
	tx:removeSelf()
end

function playPlayerDamageSound()
	if game:isSoundActive() then
		audio.play(hpSound, {channel=3, loops=1})
	end
end

function playPlayerGLSound()
	if game:isSoundActive() then
		audio.play(glSound, {channel=3, loops=1})
	end
end

return game
----------------------------------------------------------------------------------
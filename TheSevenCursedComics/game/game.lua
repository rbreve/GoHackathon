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
local currentScene, nextScene
local hpSound, glSound, shootSound, jumpSound
local enemies = {}
local physics_, leftP, isMoving, isPressedPad, isParalax
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

function game:setIsMoving(bool)
	isMoving = bool
end

function game:isMoving()
	return isMoving
end

function game:setIsParalax(bool)
	isParalax = true
end

function game:getIsParalax()
	return isParalax
end

function game:loadResources()
	hpSound =  audio.loadSound("assets/sounds/damageMikeKoenig.mp3")
	glSound = audio.loadSound("assets/sounds/bite.mp3")
	shootSound= audio.loadSound("assets/sounds/shoot_MikeKoenig.mp3")
	jumpSound= audio.loadSound("assets/sounds/Swoosh3SoundBible.com.mp3")
end

function onUpdate(event)
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
			
			if not game:getIsParalax() then
				player:setLinearVelocity(-speed, vy)
			end
			
			if not isJumping then
				player:setSequence("walk")
				player:play()
			end
			leftP = true
			isPressedPad = true
			isMoving = true
			
			lpad.alpha = 0.8
			
			player.xScale = -1
		end	
		
		if self.myName == "right" then
			local vx, vy = player:getLinearVelocity()
			
			if not game:getIsParalax() then
				player:setLinearVelocity(speed, vy)
			end
			
			if not isJumping then
				player:setSequence("walk")
				player:play()
			end
			leftP = false
			isPressedPad = true
			isMoving = true
			
			rpad.alpha = 0.8
			
			player.xScale = 1
		end	
		
		if self.myName == "b" then
			local vx, vy = player:getLinearVelocity()
			
			if not isJumping then
				playPlayerJumpSound()
				player:applyLinearImpulse( 0, -1.5, player.x, player.y )
				isJumping = true
				player:setSequence("jump")
				player:play()
			end
			--player:setSequence("stand")
			--player:play()
			
			jButton.alpha = 0.8
		end	
		
				
		if self.myName == "a" then
			playPlayerShootSound()
			
			local gum
			
			if not leftP then
				gum = display.newRect(player.x + 60, player.y - 50, 20, 20)
				gum:setFillColor(255,150,150)
				physics_.addBody(gum)
				gum:applyLinearImpulse(0.1, -0.06, gum.x, gum.y )
			else
				gum = display.newRect(player.x - 100, player.y - 50, 20, 20)
				gum:setFillColor(255,150,150)
				physics_.addBody(gum)
				gum:applyLinearImpulse(-0.1, -0.06, gum.x, gum.y )
			end
			gum.collision = onCollisionGum
			gum:addEventListener("collision", gum)
			group:insert(gum)
			
			sButton.alpha = 0.8
		end	
	end
	
	if event.phase == "ended" and state == "normal" then
		if self.myName == "left" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
			player:setSequence("stand")
			player:play()
			isPressedPad = false
			isMoving = false
			
			lpad.alpha = 0.5
		end	
		
		if self.myName == "right" then
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
			player:setSequence("stand")
			player:play()
			isPressedPad = false
			isMoving = false
			
			rpad.alpha = 0.5
		end
		
		if self.myName == "b" then
			jButton.alpha = 0.5
		end
		
		if self.myName == "a" then
			sButton.alpha = 0.5
		end
	end
end

function game:eatFood()
	playPlayerGLSound()
	addGul(1)	
end

function onCollisionPlayer(event)
	if event.phase == "began" and state == "normal" then 
		if event.other.myName == "ground" then
			isJumping = false
			
			if not isPressedPad then
				player:setSequence("stand")
				player:play()
			else
				player:setSequence("walk")
				player:play()
			end
		end
		
		if event.other.myName == "enemy" then
			playPlayerDamageSound()
			addDamage(1)
		end	
		
		if event.other.myName == "food" then
			playPlayerGLSound()
			addGul(1)
			createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
			event.other:removeSelf()
		end	
		
		if event.other.myName == "door" then
			game:transitionTo(game:getNextScene(), "crossFade", 1000)
		end
	end
end

function createParticles(x, y, width, height)
	for i = 0, 4, 1 do
		local particle = display.newRect(x + math.random( -(width / 2), width ), math.random(y-40, y - 20), 10, 10)
		particle:setFillColor(255,255,255)
		physics_.addBody(particle)
		--particle:applyLinearImpulse(math.random(-0.1, 0.1), math.random(-0.6, 0), particle.x, particle.y )
		group:insert(particle)
		particle.myName = "particle"
		--particle.collision = onCollisionParticle
		--particle:addEventListener("collision", particle)
	end
end

function onCollisionGum(self, event)
	--createParticles(self.x, self.y, self.width, self.height)
	local f = function() self:removeSelf() end
	timer.performWithDelay(50,f,100)
	
	if event.other.myName == "enemy" then
		event.other:removeSelf()
	end
	
	if event.other.myName == "food" then
		event.other:removeSelf()
	end
end

function onCollisionParticle(self, event)
	if event.other.myName ~= "particle" then
		self:removeSelf()
	end
end

function game:setPlayer(pl)
	player = pl

	physics.addBody(player, {bounce=0, shape = { -15,-100, 15,-100, 15,105, -15,105 }})
	player.myName="player"
	
	player.isFixedRotation = true
	
	isJumping = false
	
	player:addEventListener("collision", onCollisionPlayer)
	Runtime:addEventListener("enterFrame", onUpdate)
end

function game:setGroup(gr)
	group = gr
end

function game:getGroup()
	return group
end

function game:setScene(sc)
	currentScene = sc
end

function game:getScene()
	return currentScene
end

function game:setNextScene(scene_)
	nextScene = scene_
end

function game:getNextScene()
	return nextScene
end

function game:setState(tx)
	state = tx
end

function game:setPhysics(py)
	physics_ = py
end

function game:getPhysics()
	return physics_
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
	
	lpad.alpha = 0.5
	rpad.alpha = 0.5
	sButton.alpha = 0.5
	jButton.alpha = 0.5
	
	gl = display.newImage(path.."gluttony"..gluttony..".png", 20, 20)
	hpB = display.newImage(path.."power"..hp..".png", 250, 20)
	
	lpad.touch = playerBehaviour
	rpad.touch = playerBehaviour
	sButton.touch = playerBehaviour
	jButton.touch = playerBehaviour
	
	lpad:addEventListener("touch", lpad)
	rpad:addEventListener("touch", rpad)
	sButton:addEventListener("touch", sButton)
	jButton:addEventListener("touch", jButton)
	
	gl:toFront()
	lpad:toFront()
	rpad:toFront()
	sButton:toFront()
	jButton:toFront()
	
	hpB:toFront()
	
	group:insert(rpad)
	group:insert(sButton)
	group:insert(jButton)
	group:insert(gl)
	group:insert(hpB)
	group:insert(lpad)
	
	
	return group
end

function addGul(value)
	local path = "assets/images/ui/"
	
	gluttony = gluttony + value
	
		gl:removeSelf()
		gl = display.newImage(path.."gluttony"..gluttony..".png", 20, 20)
		gl:toFront()
		group:insert(gl)
			
		if gluttony >= 4 then
			gluttony = 4
			
			player:removeEventListener("collision", onCollisionPlayer)
			lpad:removeEventListener("touch", lpad)
			rpad:removeEventListener("touch", rpad)
			sButton:removeEventListener("touch", sButton)
			jButton:removeEventListener("touch", jButton)
			Runtime:removeEventListener("enterFrame", onUpdate)
			
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
		hpB = display.newImage(path.."power"..hp..".png", 250, 20)
		hpB:toFront()
		group:insert(hpB)
			
		if hp <= 0 then
			hp = 0
			
			player:removeEventListener("collision", onCollisionPlayer)
			lpad:removeEventListener("touch", lpad)
			rpad:removeEventListener("touch", rpad)
			sButton:removeEventListener("touch", sButton)
			jButton:removeEventListener("touch", jButton)
			Runtime:removeEventListener("enterFrame", onUpdate)
			
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
		audio.play(hpSound, {channel=3, loops=0})
	end
end

function playPlayerGLSound()
	if game:isSoundActive() then
		audio.play(glSound, {channel=4, loops=0})
	end
end

function playPlayerShootSound()
	if game:isSoundActive() then
		audio.stop({channel=5})
		audio.play(shootSound, {channel=5, loops=0})
	end
end

function playPlayerJumpSound()
	if game:isSoundActive() then
		audio.stop({channel=5})
		audio.play(jumpSound, {channel=6, loops=0})
	end
end

function playBackgroundMusic(name)
	if game:isMusicActive() then
		audio.play("assets/music/", {channel=1, loops=0})
	end
end

function stopBackgroundMusic()
		audio.stop({channel=1})
end

return game

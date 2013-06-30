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
local hpSound, glSound, shootSound, jumpSound, painMonster
local physics_, leftP, isMoving, isPressedPad, isParalax, canShoot, burger, burgerInt, bPart1, bPart2, bPart3, bPart4, bPart5, burgerReady, count
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
	
	--physics_ = nil
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
	isParalax = bool
end

function game:getIsParalax()
	return isParalax
end

function game:getPlayer()
	return player
end

function game:loadResources()
	hpSound =  audio.loadSound("assets/sounds/damageMikeKoenig.mp3")
	glSound = audio.loadSound("assets/sounds/bite.mp3")
	shootSound= audio.loadSound("assets/sounds/shoot_MikeKoenig.mp3")
	jumpSound= audio.loadSound("assets/sounds/Swoosh3SoundBible.com.mp3")
	painMonster = audio.loadSound("assets/sounds/pain.mp3")
end

function onUpdate(event)
	if state == "normal" then
		physics.start()
		
		if player.y  > 1000 then
			playPlayerDamageSound()
			addDamage(4)
		end
		
		if currentScene == "level3" then
			burgerBehavior ()
		end
	end
	
	if state == "cutScene" then
	
	end
	
	if state == "pause" then
		physics.pause()
	end
	
	if state == "dead" then
	
	end
end

function burgerBehavior ()
		p = function()
			local intenger = math.random(1,5)
			local burgers = display.newImage("assets/images/objects/b"..intenger..".png", math.random( 0, 600 ), -20)
			physics_.addBody(burgers)
			if group then
				group:insert(burgers)
			end
			burgers.myName = "burgers"..intenger
			burgers.collision = onCollisionBurger
			burgers:addEventListener("collision", burgers)
		end
		
		if count > 25 then
			timer.performWithDelay(50, p)
			count = 0
		else
			count = count + 1
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
		
		if canShoot then
			playPlayerShootSound()
			
			local gum
			
			if not leftP then
				gum = display.newImage("assets/images/objects/candy.png", player.x + 70, player.y - 50, 20, 20)
				gum:setFillColor(255,150,150)
				physics_.addBody(gum)
				gum:applyLinearImpulse(0.1, -0.06, gum.x, gum.y )
			else
				gum = display.newImage("assets/images/objects/candy.png", player.x - 90, player.y - 50, 20, 20)
				gum:setFillColor(255,150,150)
				physics_.addBody(gum)
				gum:applyLinearImpulse(-0.1, -0.06, gum.x, gum.y )
			end
			gum.collision = onCollisionGum
			gum:addEventListener("collision", gum)
			group:insert(gum)
			
			sButton.alpha = 0.8
			
			local t = function()
				canShoot = true
			end
			timer.performWithDelay(100, t) 
			end
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
		
		local patt = "[1234567890]"
		
		if string.match(event.other.myName, patt) and event.other.myName ~= "burgers1" and event.other.myName ~= "burgers2" and event.other.myName ~= "burgers3" and event.other.myName ~= "burgers4" and event.other.myName ~= "burgers5" then
			playPlayerDamageSound()
			addDamage(1)
		end	
		
		if event.other.myName == "food" then
			playPlayerGLSound()
			addGul(1)
			createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
			event.other:removeSelf()
		end	
		
		if event.other.myName == "burgers1" then
			bPart1 = true
			burgerInt = 1
			burger = display.newImage("assets/images/ui/burger"..burgerInt..".png", 500,10)
			group:insert(burger)
		end
		
		if event.other.myName == "burgers2" then
			if bPart1 and not bPart2 then 
				bPart2 = true
				burgerInt = 2
				burger = display.newImage("assets/images/ui/burger"..burgerInt..".png", 500,10)
				group:insert(burger)
			end
		end
		
		if event.other.myName == "burgers3" then
			if bPart2 and not bPart3 then
				bPart3 = true
				burgerInt = 3
				burger = display.newImage("assets/images/ui/burger"..burgerInt..".png", 500,10)
				group:insert(burger)
			end
		end
		
		if event.other.myName == "burgers4" then
			if bPart3 and not bPart4 then
				bPart4 = true
				burgerInt = 4
				burger = display.newImage("assets/images/ui/burger"..burgerInt..".png", 500,10)
				group:insert(burger)
			end
		end
		
		if event.other.myName == "burgers5" then
			if bPart4 and not bPart5 then
				bPart5 = true
				burgerInt = 5
				burgerReady = true
				burger = display.newImage("assets/images/ui/burger"..burgerInt..".png", 500,10)
				group:insert(burger)
				createBurger()
			end
		end
		
		if event.other.myName == "door" then
			state = "nil"
			player:setSequence("stand")
			player:play()
			game:transitionTo(game:getNextScene(), "crossFade", 1000)
		end
	end
end

			
function createParticles(x, y, width, height)
	for i = 0, 4, 1 do
		local particle = display.newRect(x + math.random( -(width / 2), width ), math.random(y-40, y - 20), 10, 10)
		particle:setFillColor(255,255,255)
		local p = function()
			physics_.addBody(particle)
			particle:applyLinearImpulse(math.random(-0.1, 0.1), math.random(0, 0.01), particle.x, particle.y )
			if group then
				group:insert(particle)
			end
			particle.myName = "particle"
			particle.collision = onCollisionParticle
			particle:addEventListener("collision", particle)
		end
	
		timer.performWithDelay(50, p) 		
	end
end

function onCollisionGum(self, event)
	createParticles(self.x, self.y, self.width, self.height)
	self:removeSelf()
	if event.other.myName == "enemy" then
		event.other:removeSelf()
	end
	
	if event.other.myName == "food" then
		event.other:removeSelf()
	end
	
	local patt = "[1234567890]"
		
	if string.match(event.other.myName, patt)  and event.other.myName ~= "burgers1" and event.other.myName ~= "burgers2" and event.other.myName ~= "burgers3" and event.other.myName ~= "burgers4" and event.other.myName ~= "burgers5" then
		if tonumber(event.other.myName) > 1 then
			event.other.myName = tonumber(event.other.myName) - 100
			print(event.other.myName)
			
			if tonumber(event.other.myName) < 1 then
				monsterDead()
				createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
				transition.to( event.other, { time=300, alpha=0 } )
			end
			
		else
			monsterDead()
			createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
			transition.to( event.other, { time=300, alpha=0 } )
			--event.other:removeSelf()
		end	
	end
end

function createBurger()
			local 	burger_ = display.newImage("assets/images/ui/burger5.png", player.x + 150, player.y - 50, 60, 60)
			
			local p = function() 
				if not leftP then
				physics_.addBody(burger_)
				burger_:applyLinearImpulse(1, -1, burger_.x, burger_.y )
			else
				physics_.addBody(burger_)
				burger_:applyLinearImpulse(-1, -1, burger_.x, burger_.y )
			end
			burger_.collision = onCollisionBurger
			burger_:addEventListener("collision", burger_)
			group:insert(burger_)
			burger:removeSelf()
			sButton.alpha = 0.8
			burgerReady = false
			bPart1= false; bPart2 = false; bPart3 = false; bPart4 = false; bPart5= false;
			burgetInt = 0
			end
			
			timer.performWithDelay(100, p)
end

function onCollisionBurger(self, event)
	local patt = "[1234567890]"
		
	if string.match(event.other.myName, patt)  and event.other.myName ~= "burgers1" and event.other.myName ~= "burgers2" and event.other.myName ~= "burgers3" and event.other.myName ~= "burgers4" and event.other.myName ~= "burgers5" then
		if tonumber(event.other.myName) > 1 then
			event.other.myName = tonumber(event.other.myName) - 200
			print(event.other.myName)
			
			if tonumber(event.other.myName) < 1 then
				monsterDead()
				createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
				transition.to( event.other, { time=300, alpha=0 } )
			end
		else
			monsterDead()
			createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
			transition.to( event.other, { time=300, alpha=0 } )
			--event.other:removeSelf()
		end	
	end
end

function onCollisionParticle(self, event)
	if event.other.myName ~= "particle" then
		self:removeSelf()
	end
end

function onCollisionBurger(self, event)
	if event.other.myName == "ground" or  event.other.myName == "player" then
		createParticles(event.other.x, event.other.y, event.other.width, event.other.height)
		self:removeSelf()
	end
end

function game:setPlayer(pl)
	player = pl
	local p = function()
		physics.addBody(player, {bounce=0, shape = { -15,-100, 15,-100, 15,105, -15,105 }})
		player.isFixedRotation = true
			
		player:addEventListener("collision", onCollisionPlayer)
		Runtime:addEventListener("enterFrame", onUpdate)
		game:setState("normal")
	end
	player.myName = "player"
	canShoot = true
	burgerInt = 0
	count = 0
	timer.performWithDelay(50, p) 
	
	isJumping = false
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

function game:getState()
	return state
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
				state = "dead"
				lives = lives - 1
				gameOver()
			else		
				state = "dead"
				lives = lives - 1
				gluttony = 0
				game:resetScene()
			end
		end
end

function addDamage(value)
	local path = "assets/images/ui/"
	
	hp = hp - value
	if hp <= 0 then
			hp = 0
	end
	
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
				state = "dead"
				lives = lives - 1
				gameOver()
			else	
				state = "dead"
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

function monsterDead()
	if game:isSoundActive() then
		audio.play(painMonster, {channel=7, loops=0})
	end
end


function playBackgroundMusic(name)
	if game:isMusicActive() then
		local song = audio.loadSound("assets/music/"..name)
		audio.play(song, {channel=1, loops=99999})
	end
end

function stopBackgroundMusic()
	if audio.isChannelPlaying(1) then
		audio.stop({channel=1})
	end
end

return game
----------------------------------------------------------------------------------
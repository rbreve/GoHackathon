----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local dialogs = require("game.dialogs")
----------------------------------------------------------------------------------
local bMusic, bSound, chkMusic, chkSound, gGroup
----------------------------------------------------------------------------------
local function saveSettings()
	game:setMusic(bMusic)
	game:setSound(bSound)
end

local function onSave(event)
	if event.phase == "began" then
		saveSettings()
		game:transitionTo("menu", "slideRight", 1000)
	end
end

local function onBack(event)
	if event.phase == "began" then
		game:transitionTo("menu", "slideRight", 1000)
	end
end

local function onMusicPressed(event)
	if event.phase == "began" then
		bMusic = not bMusic
		if bMusic then
			chkMusic = display.newRect((display.contentWidth / 2) + 60,105, 30, 30)
			chkMusic:setFillColor(255,0,0,255)
		else
			chkMusic = display.newRect((display.contentWidth / 2) + 60,105, 30, 30)
			chkMusic:setFillColor(255,255,255,255)
		end
		gGroup:insert(chkMusic)
	end
end

local function onSoundPressed(event)
	if event.phase == "began" then
		 bSound = not bSound
		if bSound then
			chkSound = display.newRect((display.contentWidth / 2) + 60,150, 30, 30)
			chkSound:setFillColor(255,0,0,255)
		else
			chkSound = display.newRect((display.contentWidth / 2) + 60,150, 30, 30)
			chkSound:setFillColor(255,255,255,255)
		end
		gGroup:insert(chkSound)
	end
end
----------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	gGroup = self.view
	
	local back, save, buttonWidth, buttonHeight
	local textMusic, textSound
	
	buttonWidth = 100
	buttonHeight = 30
	
	textMusic = display.newText(dialogs["music"](), (display.contentWidth / 2) - 100,100, game:getFont(), 30)
	textSound = display.newText(dialogs["sound"](), (display.contentWidth / 2) - 100,150, game:getFont(), 30)
	
	save = display.newRect((display.contentWidth / 2) - (buttonWidth * -0.05), (display.contentHeight / 1.2),buttonWidth,buttonHeight)
	back = display.newRect((display.contentWidth / 2) - (buttonWidth * 1.05), (display.contentHeight / 1.2),buttonWidth,buttonHeight)
	
	save:addEventListener("touch", onSave)
	back:addEventListener("touch", onBack)
	
	bMusic = game:isMusicActive(); bSound = game:isSoundActive() 
	
		
	if bMusic then
		chkMusic = display.newRect((display.contentWidth / 2) + 60,105, 30, 30)
		chkMusic:setFillColor(255,0,0,255)
	else
		chkMusic = display.newRect((display.contentWidth / 2) + 60,105, 30, 30)
		chkMusic:setFillColor(255,255,255,255)
	end
	
	if bSound then
		chkSound = display.newRect((display.contentWidth / 2) + 60,150, 30, 30)
		chkSound:setFillColor(255,0,0,255)
	else
		chkSound = display.newRect((display.contentWidth / 2) + 60,150, 30, 30)
		chkSound:setFillColor(255,255,255,255)
	end
	
	chkMusic:addEventListener("touch", onMusicPressed)
	chkSound:addEventListener("touch", onSoundPressed)
	
	group:insert(save)
	group:insert(back)
	group:insert(textMusic)
	group:insert(textSound)
	group:insert(chkMusic)
	group:insert(chkSound)
end
scene:addEventListener( "createScene", scene )


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	storyboard.purgeAll()
end
scene:addEventListener( "enterScene", scene )

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
end
scene:addEventListener( "exitScene", scene )

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
end
scene:addEventListener( "destroyScene", scene )


return scene
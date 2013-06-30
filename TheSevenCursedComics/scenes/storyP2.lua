----------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local dialogs = require("game.dialogs")
----------------------------------------------------------------------------------
local function onTouch(event)
	if event.phase == "began" then
		Runtime:removeEventListener("touch", onTouch)
		game:transitionTo("storyP3", "crossFade", 2000)
	end
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local music

	if game:isMusicActive() then
		music = audio.loadSound("assets/music/FrostWaltz.mp3")
		audio.play(music, {channel=2, loops=-1})
	end
end
scene:addEventListener( "createScene", scene )


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	local path = "assets/images/backgrounds/"
	local door
	local text,text2
	
	door = display.newImageRect(path.."door.jpg", display.contentWidth, display.contentHeight)
	door.x = (door.width / 2); door.y = (door.height / 2)
	door.alpha = 0
	transition.to( door, { time=1000, alpha=1 } )
			
	text = display.newText(dialogs["storyP2"](), 5, display.contentHeight, display.contentWidth - 10, display.contentHeight , game:getFont(), game:getFontSize())
	text:setTextColor(255,255,0)
	transition.to( text, { time=5000, y = display.contentHeight / 0.85} )
	
	text2 = display.newText(dialogs["storyP2"](), 6, display.contentHeight +2, display.contentWidth - 10, display.contentHeight , game:getFont(), game:getFontSize())
	text2:setTextColor(0,0,0)
	transition.to( text2, { time=5000, y = display.contentHeight / 0.85} )
			
	group:insert(door)
	group:insert(text2)
	group:insert(text)
	
	Runtime:addEventListener("touch", onTouch)
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
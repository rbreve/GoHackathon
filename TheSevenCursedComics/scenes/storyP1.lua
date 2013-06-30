----------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local dialogs = require("game.dialogs")
----------------------------------------------------------------------------------
local rain1, rain2
local rainTime = 100
----------------------------------------------------------------------------------
local function onRain()
	if rain1.alpha > 0.69 then
		rain1.alpha = 0.69
		transition.to( rain1, { time=rainTime, alpha=0 } )
		transition.to( rain2, { time=rainTime, alpha=0.7 } )
	elseif rain1.alpha == 0 then
		rain1.alpha = 0.01
		transition.to( rain1, { time=rainTime, alpha=0.7 } )
		transition.to( rain2, { time=rainTime, alpha=0 } )
	end
	
	--print(rain1.alpha)
end

local function onTouch(event)
	if event.phase == "began" then
		Runtime:removeEventListener("enterFrame", onRain)
		Runtime:removeEventListener("touch", onTouch)
		game:transitionTo("storyP2", "zoomInOutFade", 2000)
		--game:transitionTo("storyP2", "slideLeft", 500)
	end
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
end
scene:addEventListener( "createScene", scene )
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	local path = "assets/images/backgrounds/"
	local house
	local thundersBg
	local text, text2

	house = display.newImageRect(path.."house.jpg", display.contentWidth, display.contentHeight)
	house.x = (house.width / 2); house.y = (house.height / 2)
	house.alpha = 0
	transition.to( house, { time=3000, alpha=1 } )
	
	rain1 = display.newImageRect(path.."rain1.png", display.contentWidth, display.contentHeight)
	rain1.x = (rain1.width / 2); rain1.y = (rain1.height / 2)
	rain1.alpha = 0.68
	transition.to( rain1, { time=1000, alpha=0 } )
	
	rain2 = display.newImageRect(path.."rain2.png", display.contentWidth, display.contentHeight)
	rain2.x = (rain2.width / 2); rain2.y = (rain2.height / 2)
	rain2.alpha = 0
	transition.to( rain2, { time=1000, alpha=0.7 } )
	
	text = display.newText(dialogs["storyP1"](), 5, display.contentHeight, display.contentWidth - 10, display.contentHeight , game:getFont(), 20)
	text:setTextColor(255,255,0)
	transition.to( text, { time=5000, y = display.contentHeight / 0.85} )
	
	text2 = display.newText(dialogs["storyP1"](), 6, display.contentHeight +2, display.contentWidth - 10, display.contentHeight , game:getFont(), 20)
	text2:setTextColor(0,0,0)
	transition.to( text2, { time=5000, y = display.contentHeight / 0.85} )
	
	Runtime:addEventListener("enterFrame", onRain)
	
	if game:isMusicActive() then
		thundersBg = audio.loadSound("assets/sounds/Thunder_Mike_Koenig.mp3")
		audio.play(thundersBg, {channel=1, loops=-1})
		audio.setVolume(0.5, {channel=1})
	end
		
	group:insert(house)
	group:insert(rain1)
	group:insert(rain2)
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
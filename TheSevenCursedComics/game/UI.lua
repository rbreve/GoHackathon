----------------------------------------------------------------------------------
--UI.lua
----------------------------------------------------------------------------------
local UI = {}

function UI:loadUI()
	local group = display.newGroup()
	
	local lPad, rPad, sButton, jButton
	local path = "assets/images/ui/"
	
	lpad = display.newRectImage(path.."lpad.png", 10, display.contentHeight - 30, 100,75)
	lpad.myname = "left"
	rpad = display.newRectImage(path.."rpad.png", 60, display.contentHeight - 30, 100,75)	
	rpad.myname = "right"
	
	lpad.touch = game:playerBehaviour
	rpad.touch = game:playerBehaviour
	
	lpad:addEventListener("touch", lpad)
	rpad:addEventListener("touch", rpad)
	
	group:insert(lpad)
	group:insert(rpad)
	return group
end

return UI
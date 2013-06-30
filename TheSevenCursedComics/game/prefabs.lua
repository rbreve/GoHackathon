----------------------------------------------------------------------------------
local prefabs = {}
local path = "assets/images/objects/"
----------------------------------------------------------------------------------
function prefabs:createBackground(r, g, b)
	local background = display.newRect(0,0, display.contentWidth, display.contentHeight)
	background:setFillColor(r, g, b)
	background:toBack()
	local group = game:getGroup()
	group:insert(background)
end

function prefabs:createPlatform(x, y)
end

function prefabs:createDoor(x, y, nextScene)
	local door = display.newImage(path.."exit_door.png", x, y)
	door.myName = "door"
	game:setNextScene(nextScene)
	local physics = game:getPhysics()
	physics.addBody(door, "kinematic")
	local group = game:getGroup()
	group:insert(door)
	
	return door
end

return prefabs
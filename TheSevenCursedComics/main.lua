-----------------------------------------------------------------------------------------
--
-- main.lua
-- comentario de prueba rbreve@gmail.com
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"
game = require("game.game")
game:loadResources()
system.activate("multitouch")
--physics = require("physics")
display.setStatusBar(display.HiddenStatusBar)

-- load scenetemplate.lua
 
storyboard.gotoScene( "scenes.menu" )
--storyboard.gotoScene( "scenes.menu" )
 
-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
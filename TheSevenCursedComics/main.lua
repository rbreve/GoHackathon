-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"
display.setStatusBar(display.HiddenStatusBar)

-- load scenetemplate.lua
storyboard.gotoScene( "scenes.menu" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
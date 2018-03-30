-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
-- Constants
local centerX = display.contentCenterX



-- Require the translation file
local t = require("translation")

-- Display text on the screen.  Text will be translated if a translation exists
local nameText = display.newText( t.t("What is your name?"), centerX, 100, native.systemFont, 16 )
local ageText = display.newText( t.t("How old are you?"), centerX, 200, native.systemFont, 16 )


local continueButton = widget.newButton(
    {
        label = t.t("Press to continue"),
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
 
-- Center the button
continueButton.x = centerX
continueButton.y = 300
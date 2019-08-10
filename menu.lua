local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local menuScene = self.view
  menuScene:insert(display.newText({fontSize = 32,  text= 'Menu', x = display.actualContentWidth / 2, y= 200}))
  menuScene:insert(widget.newButton({
      cornerRadius = 1,
      fillColor = { default={0,0.5,0.8,1}, over={0, 0.6, 0.9, 1} },
      height = 48,
      label = 'Start',
      labelColor = { default={1,1,1}, over={0.6,0.6,0.6}},
      shape = "roundedRect",
      strokeColor = { default={0,1,0.4,1}, over={0,0.8,1,1} },
      strokeWidth = 2,
      width = 200,
      x = display.actualContentWidth / 2,
      y = 280,
      onRelease = function() composer.gotoScene('game') end
    })
   )
end


-- show()
function scene:show( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
-- Code here runs when the scene is still off screen (but is about to come on screen)

elseif ( phase == "did" ) then
-- Code here runs when the scene is entirely on screen

end
end


-- hide()
function scene:hide( event )

local sceneGroup = self.view
local phase = event.phase

if ( phase == "will" ) then
-- Code here runs when the scene is on screen (but is about to go off screen)

elseif ( phase == "did" ) then
-- Code here runs immediately after the scene goes entirely off screen

end
end


-- destroy()
function scene:destroy( event )

local sceneGroup = self.view
-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

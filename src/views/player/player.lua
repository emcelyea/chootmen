local ship = {
	shootRate = 600,
	shootSpeed = 600,
	shootType = 'single',
	timeTilNextShot = 0
}

local displays = {}

function ship.create(persist)
end

function ship.setShooting(val)
	ship.shooting = val
	if val == false then
		ship.timeTilNextShot = 0
	end
end

local function dragShip( event )
 
    local ship = event.target
    local phase = event.phase
 
    if ( "began" == phase ) then
        ship.touchOffsetX = event.x - ship.x
        ship.touchOffsetY = event.y - ship.y

    elseif ( "moved" == phase ) then
        ship.x = event.x - ship.touchOffsetX
        ship.y = event.y - ship.touchOffsetY
    end
    return true
end

function ship.render(stats)
	displays.ship = display.newRect(display.actualContentWidth/2, display.actualContentHeight - 248, 32, 32)
	displays.ship.strokeWidth = 3
	displays.ship:setFillColor( 0,1,0 )
	displays.ship:setStrokeColor( 0, 1, 0 )
	displays.ship:addEventListener( 'touch', dragShip)
end

function ship.onFrame()
	if ship.shooting then
		if ship.timeTilNextShot <= 0 then
			fireShot()
			ship.timeTilNextShot = ship.shootRate
		else
			ship.timeTilNextShot = ship.timeTilNextShot - 33
		end
	end
end

function fireShot()
	if ship.shootType == 'single' then
		fireSingleShot()
	end
end

ship.lasers = {}
local laserLength = 0
function getNextIndex()
	for key, val in pairs(ship.lasers) do
		if val == nil then
			return key
		end
		laserLength = laserLength + 1
	end
	return laserLength
end

function fireSingleShot()
  local newLaser = display.newRect( displays.ship.x, displays.ship.y, 8, 16 )
  newLaser.isBullet = true
  newLaser.myName = "laser"
  newLaser.damage = stats.get

  newLaser.x = displays.ship.x
  newLaser.y = displays.ship.y
  newLaser:toBack()
  local laserIndex = getNextIndex()
 	transition.to( newLaser, { y=-16, time=ship.shootSpeed, 
 		onComplete = function() 
 			display.remove( newLaser ) 
 			ship.lasers[laserIndex] = nil
 		end } )
 	newLaser.onHit = function()
 		display.remove(newLaser)
 		newLaser.active = false
 		ship.lasers[laserIndex] = nil
 	end
 	ship.lasers[laserIndex] = newLaser
end

return ship
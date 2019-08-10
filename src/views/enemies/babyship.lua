local babyship = {}
babyship.width = 32
babyship.height = 32

function babyship.spawn(x, y, difficulty)
	local ship = {
		active = true,
		collisionDamage = 5,
		display = display.newRect(x,y, babyship.width, babyship.height),
		health = 12
	}
	ship.display:setFillColor( 1, 0, 0 )

	ship.behavior = function()
		ship.display.y = ship.display.y + 2
		if ship.display.y > display.actualContentHeight - 200 then
			ship.active = false
			display.remove(ship.display)
			ship.display = nil
		end
	end

	ship.onHitLaser = function(player)
		ship.health = ship.health - player.stats.dmg.current
		if ship.health < 0.1 then 
			ship.active = false
			display.remove(ship.display)
			ship.display = nil
		end
	end

	return ship
end

return babyship
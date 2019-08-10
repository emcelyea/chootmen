local enemies = {}
local babyship = require 'src.views.enemies.babyship'

enemies.framespassed = 0
enemies.active = {}
enemies.lasers = {}
local freeIndex

function randomXValue(enemyWidth)
	return math.random(display.actualContentWidth - enemyWidth) + enemyWidth
end

function isColliding(enemy, laser)
end

function enemies.create()
end

-- spawn any new enemies, run behavior for all existing, check if any need to be removed
function enemies.onFrame(player)
	enemies.framespassed = enemies.framespassed + 1

	-- new
	if enemies.framespassed % 60 == 0 then
		freeIndex = findFreeIndex()
		enemies.active[freeIndex] = babyship.spawn(randomXValue(babyship.width), -10, enemies.framespassed)
	end

	-- update existing
	for key, enemy in pairs(enemies.active) do
		if enemy ~= nil then
			enemy.behavior()
		end

		if enemy.active == false then
			enemies.active[key] = nil
		end
	end
end

local length = 0
function findFreeIndex()
	for key, val in pairs(enemies.active) do
		if val == nil then
			return key
		end
		length = length + 1
	end
	return length
end

return enemies
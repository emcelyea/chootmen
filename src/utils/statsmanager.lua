local statsmanager = {}
local pointsToTriggerUpgrade = 5

local pointsMultiplier = {	
												base = 1,
												count = 0,
												current = 1,
												multiplier = 0.1
											}
local upgrades = {}
local count = 0
local currentUpgrade

-- increment current stat
function statsmanager.increment()
	-- update overall multiplier
	pointsMultiplier.count = pointsMultiplier.count + 1
	if pointsMultiplier.count == pointsToTriggerUpgrade then
		pointsMultiplier.count = 0
		pointsMultiplier.current = pointsMultiplier.current + pointsMultiplier.current * pointsMultiplier.multiplier
	end

	-- update `current` for currentUpgrade
	if currentUpgrade ~= nil and upgrades[currentUpgrade] ~= nil then
		upgrades[currentUpgrade].count = upgrades[currentUpgrade].count + 1
		if upgrades[currentUpgrade].count == pointsToTriggerUpgrade then
			upgrades[currentUpgrade].count = 0
			upgrades[currentUpgrade].current = 
				upgrades[currentUpgrade].current + (upgrades[currentUpgrade].current * upgrades[currentUpgrade].multiplier) * pointsMultiplier.current
			print(upgrades[currentUpgrade].current, (upgrades[currentUpgrade].current * upgrades[currentUpgrade].multiplier) * pointsMultiplier.current)
		end
	end
	print(upgrades[currentUpgrade].current)
end
-- decrement current stat
function statsmanager.reset()
	upgrades[currentUpgrade].count = 0;
	pointsMultiplier.current = pointsMultiplier.base
end

-- i.e. addUpgradePath('damage', 10, .1)
function statsmanager.addUpgradePath(name, b, m)
	upgrades[name] = {base = b, count = 0, current = b, multiplier = m}
	count = count + 1
end

-- set current upgrade key
function statsmanager.setCurrentUpgrade(key)
	currentUpgrade = key
end
function statsmanager.getCurrentUpgradeKey()
	return currentUpgrade
end
-- return value of upgrade key
function statsmanager.getCurrentUpgrade(key)
	return upgrades[currentUpgrade].current
end

function statsmanager.getUpgradeValue(key)
	if upgrades[key] == nil then
		print(key, 'invalid key to get val for')
		return 0
	end
	return ugprades[key].current
end

function statsmanager.getMultiplier()
	return pointsMultiplier.current
end

function statsmanager.getAllUpgrades()
	return upgrades
end

function statsmanager.getLength()
	return count
end
return statsmanager
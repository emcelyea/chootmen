local inputbar = {}
local widget = require( "widget" )
inputbar.statsmanager = nil



local displays = {}

function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function setupgradePath(upgrade)
	return function()
		inputbar.statsmanager.setCurrentUpgrade(upgrade)
		local stats = inputbar.statsmanager.getAllUpgrades()
		for key, value in pairs(stats) do
			displays[key..'button']:setFillColor(0,0,0)
		end
		displays[upgrade..'button']:setFillColor(0.2,0.2,0.2)
	end
end

local dPad = {
	[1] = 'up',
	[2] = 'right',
	[3] = 'down',
	[4] = 'left' 
}
-- TODO FINISH UP THE GOTDAMN MOVE KEYS
function inputbar.render(statsmanager, ship)
	inputbar.statsmanager = statsmanager
	-- add in choot button
	local chootButton = {
			width = 56,
			height = 56,
			x = 56,
			y = display.actualContentHeight - 200,
			label = 'Choot',
      shape = "roundedRect",
      cornerRadius = 1,
      fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
      strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
      strokeWidth = 4
	}
	chootButton.onPress = function()ship.setShooting(true)end
	chootButton.onRelease = function()ship.setShooting(false)end
	displays.chootButton = widget.newButton(chootButton)

	-- add in dPad buttons
	local dPadButtons = {
		width = 28,
		height = 28,
	}
	-- add in stats buttons
	local stats = inputbar.statsmanager.getAllUpgrades()
	local length = inputbar.statsmanager.getLength()
	local controlButtonSpace = 48 + 64 + 32 -- space input button `choot` & `move` takeup
	local remainingWidth = display.actualContentWidth - controlButtonSpace * 2
	local nextButtonOffset = remainingWidth / length / 2
	local textOptions
	for key, value in pairs(stats) do
		textOptions = {
			x = controlButtonSpace + nextButtonOffset,
			y = display.actualContentHeight - 200,
	  	width = 40,
	  	height = 40,
	  	cornerRadius = 1,
			strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
	  	strokeWidth = 4,
	  	label = key,
	  	shape = "roundedRect",

	  	onRelease = setupgradePath(key)
	  }
		displays[key..'button'] = widget.newButton(textOptions)
		displays[key..'button']:setFillColor(0,0,0)

		nextButtonOffset = nextButtonOffset + remainingWidth / length
	end
	local currentUpgrade = inputbar.statsmanager.getCurrentUpgradeKey()
	displays[currentUpgrade..'button']:setFillColor(0.2,0.2,0.2)
end

function inputbar.onFrame()
	local stats = inputbar.statsmanager.getAllUpgrades()
	local length = inputbar.statsmanager.getLength()
	local controlButtonSpace = 48 + 64 + 32 -- space input button `choot` & `move` takeup
	local remainingWidth = display.actualContentWidth - controlButtonSpace * 2
	local nextButtonOffset = remainingWidth / length / 2
	local textOptions = {}
	for key, value in pairs(stats) do
		if displays[key..'val'] ~= nil then
			display.remove(displays[key..'val'])
		end
		textOptions.x = controlButtonSpace + nextButtonOffset
		textOptions.text = round(value.current, 1)
		textOptions.y = display.actualContentHeight - 168
		textOptions.fontSize = 16
		displays[key..'val'] = display.newText(textOptions)
		nextButtonOffset = nextButtonOffset + remainingWidth / length
	end
end

return inputbar
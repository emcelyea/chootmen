-- local questionbar = require 'src.views.questionbar.questionbar'
-- local statsmanager = require 'src.utils.statsmanager'
-- local inputbar = require 'src.views.inputbar.inputbar'
-- local enemies = require 'src.views.enemies.enemies'
--local collisionmanager = require 'src.utils.collisionmanager'
local composer = require( "composer" )
local playerdata = require 'src.utils.playerdata'
local player = require 'src.views.player.player'
local enemies = require 'src.views.enemies.enemies'

-- playerdata.save(data)
local playerPersistData = playerdata.load()

-- global variables bound to composer
composer.setVariable('playerPersistData', playerPersistData)
composer.setVariable('player', player.create())
composer.setVariable('enemies', enemies.create())

composer.gotoScene( "menu" )

--function gameLoop()
--	player.stats = statsmanager.getAllUpgrades()
--	questionbar.onFrame()
--	inputbar.onFrame()
--	player.onFrame()
--	enemies.onFrame(player)

	-- check for collisions and fire corresponding behaviors
--	collisionmanager.laserToEnemy(enemies.active, player.lasers)
--	collisionmanager.laserToPlayer(player, enemies.lasers)
--	collisionmanager.enemyToPlayer(player, enemies.active)

-- end

-- add stats field
-- statsmanager.addUpgradePath('dmg', 10, 0.1)
-- statsmanager.addUpgradePath('hp', 10, 0.1)
-- statsmanager.addUpgradePath('T', 10, 0.1)
-- statsmanager.setCurrentUpgrade('dmg')

-- render and prep stuff
--player.render(statsmanager)
--questionbar.render(statsmanager)
--inputbar.render(statsmanager, player)

--Runtime:addEventListener( "enterFrame", gameLoop)

Enemy is a table with behaviors defined

spawn(x, y, frames) 
	- will be called with coordinates and frames for any difficulty tweaks
	- returns an enemy object
	enemyObject - Required to have following properties:
		- behavior() - behavior on frame passed
		- onHitLaser(player) - behavior when hit by laser
		- onHitPlayer(player) - behavior when collides with player

extends "res://scenes/defaultLevel/ghost in cage default.gd"

func _ready():
	setSpawnDemons()

func setSpawnDemons():
	demonTipesToSpawn = [demonTipes.sword, demonTipes.fireBall]
	timeBetweenSpawn = [1, 3]
	amountOfEach = [2, 1]

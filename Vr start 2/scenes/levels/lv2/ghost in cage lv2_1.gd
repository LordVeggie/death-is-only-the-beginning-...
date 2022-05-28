extends "res://scenes/defaultLevel/ghost in cage default.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	setSpawnDemons()

func setSpawnDemons():
	demonTipesToSpawn = [demonTipes.fireBall]
	timeBetweenSpawn = [1]
	amountOfEach = [1]

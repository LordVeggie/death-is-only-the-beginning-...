extends "res://characters/ghost/ghost in cage.gd"

signal isGhostInCage

onready var nextLevelDoor = get_tree().get_nodes_in_group("nextLevelDoor")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	nextLevelDoor = get_tree().get_nodes_in_group("nextLevelDoor")[0]
	connect("isGhostInCage", nextLevelDoor, "setNumOfGhostsToFree")
	emit_signal("isGhostInCage")
	connect("ghostIsFree", nextLevelDoor, "ghostSetFree")


func setSpawnDemons():
	#overide for each cage in each level
	pass

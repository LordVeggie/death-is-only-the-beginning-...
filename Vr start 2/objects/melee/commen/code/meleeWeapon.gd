extends "res://addons/godot-xr-tools/objects/Object_pickable.gd"

onready var disposable  = get_node("/root/world origin/disposable")# where bullets should be spawned under

export var rumble = 0.0 setget setRumble, getRumble

var rng = RandomNumberGenerator.new()
export (int) var maxDamage = 1
export (int) var minDamage = 0
var damage = 1

func setRumble(rumbleValue):
	if by_controller:
		by_controller.rumble = rumbleValue

func getRumble():
	if by_controller:
		return by_controller.rumble
	else:
		return 0.0

func action():
	#overide with special code for each weapon
	pass

func setDamage(newMinDamage : int, newMaxDamage : int):
	maxDamage = newMaxDamage
	minDamage = newMinDamage

func getDamage():
	rng.randomize()
	damage = rng.randi_range(minDamage, maxDamage)
	return damage

func _on_damageArea_area_entered(area):
	if(area.has_method("hurt") and area.getBelongsTo() != 1):
		var damage = getDamage()
		area.hurt(damage, area.global_transform.origin)


func _on_damageArea_body_entered(body):
	if(body.has_method("hurt")):
		var damage = getDamage()
		body.hurt(damage, body.global_transform.origin)
		

func doDamage():
	#add damage code in here in each weapon if nessasery
	return getDamage()

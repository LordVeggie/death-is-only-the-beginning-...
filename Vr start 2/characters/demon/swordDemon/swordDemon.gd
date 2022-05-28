extends "res://characters/demon/commen/demon.gd"

onready var attackArea = $KinematicBody/mesh/demon/Spatial/attackArea
onready var animationPlayer = $AnimationPlayer
onready var col = $KinematicBody/mesh/demon/Spatial/attackArea/CollisionShape

export (int) var damage = 5
export var timeBetweenAttacks = 2
var timeSinceLastAttack = 0.0

var area
var areaToAttack

func _physics_process(delta):
	if(!animationPlayer.is_playing()):
		var areas = attackArea.get_overlapping_areas()
		
		timeSinceLastAttack += delta
		
		if (timeSinceLastAttack >= timeBetweenAttacks):
			timeSinceLastAttack = timeBetweenAttacks
		
		if(areas.size() > 1):
			for i in areas:
				area = i
				if(timeSinceLastAttack == timeBetweenAttacks and area.has_method("hurt") and area.getBelongsTo() == 1):
					areaToAttack = area
					animationPlayer.play("attack")
					timeSinceLastAttack = 0.0

func doDamage():
	areaToAttack.hurt(damage, areaToAttack.global_transform.origin)
	print(areaToAttack.get_parent().name)

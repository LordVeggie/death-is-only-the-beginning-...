extends "res://characters/demon/commen/demon.gd"

onready var fireBallSpawn =$KinematicBody/mesh/demon/fireBallSpawn
onready var animationPlayer = $AnimationPlayer
onready var disposable  = get_node("/root/world origin/disposable")
onready var attackCoolDown = $attackCoolDown


export (int) var attackRange = 10.0 
export (int) var damage = 10.0
export (int) var fireBallSpeed = 20


var fireBall = preload("res://characters/demon/commen/fireBall.tscn")
var canAttack = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if(canAttack):
		attack()
		

func attack():
	canAttack = false
	animationPlayer.play("attack")
	attackCoolDown.start()

func spawnFireBall():
	var newFireBall = fireBall.instance()
	disposable.add_child(newFireBall)
	newFireBall.global_transform = fireBallSpawn.global_transform
	#newFireBall.rotation = fireBallSpawn.rotation
	newFireBall.fireFireBall(fireBallSpawn.get_parent().global_transform.basis.z * fireBallSpeed, getDamage())

func getDamage():
	return damage


func _on_attackCoolDown_timeout():
	canAttack = true

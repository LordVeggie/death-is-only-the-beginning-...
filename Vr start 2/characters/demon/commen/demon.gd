extends Spatial

signal demonDied

onready var makeDemonHover = $makeDemonHover #use tween to do bobbing of demon idel animation
onready var demonMesh = $KinematicBody/mesh/demon #used to see demon
onready var demonEyes = $KinematicBody/mesh/demon/eyes # demon eyes use to show demon gonna attack 

onready var lookAtY = $lookAt/rotateY
onready var lookAtX = $lookAt/rotateY/rotateX

onready var player = get_tree().get_nodes_in_group("player")[0]

##################health
onready var deathAnimation = $death

func _ready():
	var demonTrans = demonMesh.translation
	makeDemonHover.interpolate_property(demonMesh, "translation", demonTrans, (demonTrans+(Vector3.UP*0.5)), 1, Tween.TRANS_CIRC, Tween.TRANS_LINEAR)
	makeDemonHover.interpolate_property(demonMesh, "translation", (demonTrans + (Vector3.UP*0.5)), demonTrans, 1, Tween.TRANS_CIRC, Tween.TRANS_LINEAR, 1)
	makeDemonHover.start()

func _process(delta):
	var playerPos = player.global_transform.origin
	lookAtY.pointFace(playerPos,delta)
	lookAtX.pointFace(playerPos,delta)

func _on_healthManager_dead():
	die()

func die():
	deathAnimation.play("death1")


func _on_death_animation_finished(anim_name):
	emit_signal("demonDied")
	queue_free()

extends Spatial

signal ghostFree

onready var makeGhostHover = $makeGhostHover
onready var ghostMesh = $RigidBody/ghost
onready var animatinPlayer = $AnimationPlayer

onready var collectionSound = $collectionSound
onready var stopPlayingCollection = $stopCollectionSound

func _ready():
	$RigidBody/CollisionShape.disabled = false
	var ghostTrans = ghostMesh.translation
	makeGhostHover.interpolate_property(ghostMesh, "translation", ghostTrans, (ghostTrans+(Vector3.UP*0.4)), 4.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	makeGhostHover.interpolate_property(ghostMesh, "translation", (ghostTrans+(Vector3.UP*0.4)), ghostTrans, 4.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 4.0)

func pickUpGhost():
	makeGhostHover.stop_all()
	$RigidBody/CollisionShape.disabled = true
	collectionSound.play()
	stopPlayingCollection.start()
	animatinPlayer.play("ghostCollected")


func _on_activateArea_body_entered(body):
	makeGhostHover.start()


func _on_activateArea_body_exited(body):
	makeGhostHover.stop_all()


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("ghostFree")
	queue_free()


func _on_stopCollectionSound_timeout():
	collectionSound.stop()

extends RigidBody

onready var animationPlayer = $AnimationPlayer
onready var explosionSound = $explosionSound

var damage = 0.0

func _ready():
	animationPlayer.stop()
	animationPlayer.play("rotation")

func fireFireBall(velovity, _damage):
	damage = _damage
	linear_velocity = velovity

func _on_damageArea_area_entered(area):
	if(area.has_method("hurt") and area.getBelongsTo() == 1):
		area.hurt(damage, area.global_transform.origin)
		animationPlayer.stop()
		explosionSound.play()
		animationPlayer.play("explosion")


func _on_fireBall_body_entered(body):
	#collided with enviornment
	animationPlayer.stop()
	explosionSound.play()
	animationPlayer.play("explosion")


func _on_lifeTimer_timeout():
	animationPlayer.stop()
	explosionSound.play()
	animationPlayer.play("explosion")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "explosion"):
		queue_free()

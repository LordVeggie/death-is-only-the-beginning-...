extends RigidBody

signal spawnAi

onready var spawnParticles = $spawnParticles
onready var collision = $CollisionShape
onready var destroyTimer = $destroyTimer

func _on_demonSpawnball_body_entered(body):
	spawnParticles.emitting = true
	destroyTimer.start()
	emit_signal("spawnAi", global_transform)

func _on_destroyTimer_timeout():
	queue_free()

extends RigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_lifeTime_timeout():
	queue_free()

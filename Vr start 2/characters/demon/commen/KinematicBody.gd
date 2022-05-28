extends KinematicBody
var movevec = Vector3(0.0, 0.0, 0.0)
export var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_translate(movevec * speed * delta )

func move(direction):
	movevec = direction

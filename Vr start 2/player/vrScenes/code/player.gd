extends Spatial

onready var camera = $"../ARVRCamera"
onready var healthManager = $"damage erea/hitBoxes/healthManager"#health
var numOfGhostsCollected = 0

var dead = false

func _ready():
	#healthManager.init()
	healthManager.connect("dead", self, "kill")
	#healthManager.connect("hurt", self, "Playerhurt")
	pass

func _physics_process(delta):
	rotate_y(deg2rad(camera.rotation_degrees.y - rotation_degrees.y)) #rotate the suff with the camera
	
	global_transform.origin = Vector3(camera.global_transform.origin.x, (camera.global_transform.origin.y-1.5), camera.global_transform.origin.z)



#############################################  Health Functions ####################################

func Playerhurt(damage, direction):
	print("hurt")

func heal(amount):
	healthManager.heal(amount)

func kill():
	get_tree().change_scene("res://scenes/levels/death/death.tscn")
	print("You Died")


func _on_Area_body_entered(body):#use to collect stuff
	if(body.get_parent().has_method('pickUpGhost')): #collect ghosts
		numOfGhostsCollected += 1
		body.get_parent().pickUpGhost()
		print(numOfGhostsCollected)

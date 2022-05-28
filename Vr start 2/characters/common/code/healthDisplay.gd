extends Spatial

onready var nav = get_tree().get_nodes_in_group("AInavigation")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var aiToMove = get_parent()

func _ready():
	pass 

func _physics_process(delta):
	moveAI()

func moveAI():
	############simple way to move ai not efficient if you have many ai #########################
	var path = nav.get_simple_path(aiToMove.global_transform.origin, player.global_transform.origin) #get a paht to the enemy

	if(path.size() > 1): #check if there is at least one enemy
		var direction : Vector3 = path[1] - aiToMove.global_transform.origin # getting the direction between the enemy and the ai
		#direction.y = 0.0  # ignoring the height diffirince if any
		direction = direction.normalized() #normalizing the size of the direction
		aiToMove.move(direction)

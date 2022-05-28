extends Spatial

onready var nextLevelTriggerCol = $nextLevelTrigger/CollisionShape
onready var showDoorIsActiveParticles = $showDoorIsActiveParticles
onready var doorGlow = $"door is active mesh"
onready var activateDoorsound = $activateDoorsound

export (int) var maxLevels = 1
export (int) var currentLevel = 0

export (int) var numOfGhostsToFree = 0

var numOfGhostsFree = 0

func _ready():
	if(currentLevel == 0 or currentLevel > maxLevels or currentLevel < 0):#for the the main menu and credits
		activateDoor()

func activateDoor():
	print("Door is now active")
	nextLevelTriggerCol.disabled = false
	showDoorIsActiveParticles.emitting = true
	activateDoorsound.play()
	doorGlow.visible = true
	

func goToNextLevel():
	if (currentLevel < maxLevels):
		print("next Level reached")
		get_tree().change_scene("res://scenes/levels/lv"+str(currentLevel+1)+"/lv"+str(currentLevel+1)+".tscn")
	elif(currentLevel == maxLevels):
		get_tree().change_scene("res://scenes/levels/credits/credits.tscn")
		print("end of game reached")
	else:
		get_tree().change_scene("res://scenes/levels/lv"+str(0)+"/lv"+str(0)+".tscn")
		print("end of game reached")
	
	

func ghostSetFree():
	numOfGhostsFree += 1
	print("number of ghosts free" + str(numOfGhostsFree))
	if(numOfGhostsFree == numOfGhostsToFree):
		activateDoor()


func _on_nextLevelTrigger_body_entered(body):
	goToNextLevel()

func setCurrentLevel(level):
	currentLevel = level

func setNumOfGhostsToFree():
	numOfGhostsToFree += 1
	print("number of ghosts to freeeeeeeeeeeeeeeeeeee :" + str(numOfGhostsToFree))

extends Spatial

enum demonTipes{sword, fireBall}

signal ghostIsFree

onready var cage = $ghostCage
onready var demonSpawner = $demonSpawner

onready var summoningSound = $summoningSound
onready var canCollectSound = $canCollectSound

onready var stopPlayingSummoning = $stopPlayingSummoning
onready var stopPlayingCanCollect = $stopCanCollectSound

export (int) var numOfDemonsToSpawn = 4

var numOfDemonsSpawnd = 0
var numOfDemonsKilled = 0

var demonTipesToSpawn : Array 
var amountOfEach : Array
var timeBetweenSpawn : Array
var alreadySpawned = false

func _on_ghost_ghostFree():
	print("ghostFree?????????????????")
	emit_signal("ghostIsFree")

func releaseGhost():
	canCollectSound.play()
	stopPlayingCanCollect.start()
	cage.queue_free()#deletes the cage

func setSpawnDemons():
	demonTipesToSpawn = [demonTipes.fireBall, demonTipes.sword]
	timeBetweenSpawn = [2, 4]
	amountOfEach = [2, 2]
	#pass# overide for each level / battel
	#call function in ready of overided script

func _on_activateArea_body_entered(body):
	if(!alreadySpawned):
		demonSpawner.spawnDemons(demonTipesToSpawn, amountOfEach,  timeBetweenSpawn)
		cage.visible = true
		summoningSound.play()
		stopPlayingSummoning.start()
		alreadySpawned = true

func _on_demonSpawner_demonDied():
	numOfDemonsKilled += 1
	if(numOfDemonsToSpawn == numOfDemonsKilled):
		releaseGhost()
		


func _on_stopPlayingSummoning_timeout():
	summoningSound.stop()

func _on_stopCanCollectSound_timeout():
	canCollectSound.stop()

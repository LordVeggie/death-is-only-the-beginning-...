extends Spatial

signal demonDied

enum demonTipes{sword, fireBall}

onready var characters = get_node("/root/world origin/characters")

var swordDemon = preload("res://characters/demon/swordDemon/swordDemon.tscn")
var fireBallDemon = preload("res://characters/demon/fireBallDemon/fireBallDemon.tscn")
var demonSpawnPoint = preload("res://characters/demon/commen/demonSpawnball.tscn")

var count = 0.0

var rng = RandomNumberGenerator.new()
var canspawnDemon = false
var spawnNextDemon = false
var newDemonSpawnPoint
var newDemonSpawnPointLocation
var demon = null

var _demonTipesToSpawn : Array

func spawnDemons(demonTipesToSpawn : Array, amountOfEach : Array, timeBetweenSpawn : Array):
	var __demonTipesToSpawn = demonTipesToSpawn.duplicate()
	var _amountOfEach = amountOfEach.duplicate()
	for num in range(demonTipesToSpawn.size()):
		num = _amountOfEach.pop_front()
		for i in range(num):
			_demonTipesToSpawn.append(__demonTipesToSpawn[0])
		__demonTipesToSpawn.pop_front()
	
	for num in range(demonTipesToSpawn.size()):
		spawnDemon(demonTipesToSpawn.pop_front(), timeBetweenSpawn.pop_front(), amountOfEach.pop_front())

func spawnDemon(_demonTipe, timeBetweenSpawn, amountToSpawn):
	
	for num in range(amountToSpawn):
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = timeBetweenSpawn*(num)
		timer.one_shot = true
		timer.connect("timeout", self, "setSpawnNextDemon")
		timer.start()

func adDmonDied():
	emit_signal("demonDied")
	print("demon died")

func setDemonSpawnLocation(point):
	newDemonSpawnPointLocation = point
	var demonTipe = _demonTipesToSpawn.pop_front()
	
	if(demonTipe == demonTipes.sword):
			demon = swordDemon.instance()
	elif(demonTipe == demonTipes.fireBall):
			demon = fireBallDemon.instance()
		
	characters.add_child(demon)
		
	demon.global_transform.origin = newDemonSpawnPointLocation.origin
	demon.connect("demonDied", self, "adDmonDied")

func setSpawnNextDemon():
	newDemonSpawnPoint = demonSpawnPoint.instance()
	characters.add_child(newDemonSpawnPoint)
	
	newDemonSpawnPoint.connect("spawnAi", self, "setDemonSpawnLocation")
	newDemonSpawnPoint.global_transform = global_transform
	newDemonSpawnPoint.linear_velocity =  global_transform.basis.y * rng.randi_range(5, 10)

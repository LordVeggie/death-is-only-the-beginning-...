extends "res://addons/godot-xr-tools/objects/Object_pickable.gd"

onready var aim = $aim
onready var targetDot = $aim/targetDot
onready var casingSpawn = $casingsSpawn
onready var smokeSpawn = $smokeSpawn
onready var disposable  = get_node("/root/world origin/disposable")# where bullets should be spawned under
onready var animationPlayer = $AnimationPlayer

onready var ammoDisplay = $ammoDisplay
onready var ammoDisplayView = $ammoDisplay/ammoDisplayView
onready var ammoCountText = $ammoDisplay/ammoDisplayView/ammoCountText

export (bool) var hasLaser = false
export (PackedScene) var casing = null
export (float) var caseEjectVelocity = 1.0
export (int) var clipSize = 10
export (int) var gunRange = 10
export var rumble = 0.0 setget setRumble, getRumble
export (bool) var hasAmmoDisplay = false
export (PackedScene) var gunSmoke = null
export (bool) var hasSmoke = true

var rng = RandomNumberGenerator.new()
export (int) var maxDamage = 1
export (int) var minDamage = 0
var damage = 1

var currentAmmo :int = 1

func _ready():
	updateAmmo(clipSize)
	displayAmmo()
	aim.cast_to.y = -(gunRange)
	ammoDisplay.visible = hasAmmoDisplay
	

func _process(delta):
	if(hasLaser):
		emitLaser()
	if (hasAmmoDisplay):
		displayAmmo()

func setRumble(rumbleValue):
	if by_controller:
		by_controller.rumble = rumbleValue

func getRumble():
	if by_controller:
		return by_controller.rumble
	else:
		return 0.0

func emitLaser():
	if (aim.is_colliding()):
		targetDot.global_transform.origin = aim.get_collision_point()
		targetDot.visible = true
	else:
		targetDot.visible = false

func ejectCasing():
	var newCasing = casing.instance()
	newCasing.transform = casingSpawn.global_transform
	newCasing.linear_velocity = (newCasing.transform.basis.x)*caseEjectVelocity
	
	disposable.add_child(newCasing)

func emitSmoke():
	var newSmoke = gunSmoke.instance()
	newSmoke.transform = smokeSpawn.global_transform
	disposable.add_child(newSmoke)

func action():
	if(!animationPlayer.is_playing()):
		if(currentAmmo > 0):
			updateAmmo(-1)
			animationPlayer.play("fire")
			emitSmoke()
			shoot()
		else:
			dryFire()

func shoot():
	#overide this function on every type of gun to do damage 
	pass

func setDamage(newMinDamage : int, newMaxDamage : int):
	maxDamage = newMaxDamage
	minDamage = newMinDamage

func getDamage():
	rng.randomize()
	damage = rng.randi_range(minDamage, maxDamage)
	return damage

func dryFire():
	pass

func updateAmmo(amount):
	currentAmmo += amount
	if(currentAmmo > clipSize):
		currentAmmo = clipSize
	if(hasAmmoDisplay):
		updateDisplayAmmo()

func displayAmmo():
	ammoDisplayView.render_target_update_mode = Viewport.UPDATE_ONCE

func updateDisplayAmmo():
	ammoCountText.text = str(currentAmmo)

func _on_reloadErea_body_entered(body):
	
	#load ammo and destroy the clip/bullet
	if (currentAmmo < clipSize):
		if(!animationPlayer.is_playing()):
			animationPlayer.play("reload")
			updateAmmo(body.getAmmoAmount())
			
			body.drop_and_free()
	else:
		#ammo is full do some thing
		pass

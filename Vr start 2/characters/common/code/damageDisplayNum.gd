extends RigidBody

var damage : int = 0
var rng = RandomNumberGenerator.new()

func setDamage(amount):
	rng.randomize()
	var numX = rng.randi_range(1, 5)
	var numY = rng.randi_range(1, 5)
	var numZ = rng.randi_range(1, 5)
	
	self.apply_impulse(Vector3(0,0,0), Vector3(numX, numY, numZ))
	
	damage = amount
	updateDisplayDamage()
	displayDamage()
	animateDamageNum()
	

func _process(delta):
	look_at(get_node("/root/world origin/players/VrControllerMain/FPController/ARVRCamera").global_transform.origin, Vector3.UP)
	pass
	

func displayDamage():
	get_node("damageDisplayNum/damageDisplayView").render_target_update_mode = Viewport.UPDATE_ONCE

func updateDisplayDamage():
	get_node("damageDisplayNum/damageDisplayView/damageText").text = str(damage)

func _on_Tween_tween_all_completed():
	queue_free()

func animateDamageNum():
	#scale 
	get_node("Tween").interpolate_property(self, 'scale', scale, Vector3(3, 3, 3), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	get_node("Tween").interpolate_property(self, 'scale', Vector3(3, 3, 3), Vector3(0.1, 0.1, 0.1), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1.5)
	#transfrom
	
	get_node("Tween").start()
	


func _on_Tween_tween_started(object, key):
	pass

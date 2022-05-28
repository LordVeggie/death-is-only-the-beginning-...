extends Spatial

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var max_health = 100
export var gibAt = -20

var currentHealth = 1

func _ready():
	init()

func init():
	currentHealth = max_health
	emit_signal("health_changed", currentHealth)
	get_node("healthDisplay/healthDisplayView/healthBar").setMaxHealth(currentHealth)
	

func hurt(damage : int, ditection: Vector3):#add damge type
	if (currentHealth <= 0):
		return
	
	currentHealth -= damage
	
	if (currentHealth <= gibAt):
		#make gibs spawn
		emit_signal("gibbed")
	
	if(currentHealth <= 0):
		emit_signal("dead")
		#print('dead')
		
	emit_signal("hurt")
	emit_signal("health_changed", currentHealth)
	
	#print('hurt ', damage, ' current health ', currentHealth)

func heal(amount :int):
	if(currentHealth <= 0):
		return
	
	currentHealth += amount
	
	if(currentHealth > max_health):
		currentHealth = max_health
	emit_signal("healed")
	emit_signal("health_changed",currentHealth)

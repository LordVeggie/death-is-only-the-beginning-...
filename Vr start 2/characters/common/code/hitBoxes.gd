extends Area

enum canBelongTo {ai, player}

export (canBelongTo) var belongsTo = canBelongTo.ai

onready var healthManager = $healthManager
onready var disposable  = get_node("/root/world origin/disposable")# where disposable should be spawned under
var damageDisplayNum = preload("res://characters/common/damageDisplayNum.tscn")

func hurt(damage : int, ditection: Vector3):
	healthManager.hurt(damage, ditection)
	
	var newDamageDisplayNum = damageDisplayNum.instance()
	disposable.add_child(newDamageDisplayNum)
	newDamageDisplayNum.global_transform.origin = healthManager.global_transform.origin
	newDamageDisplayNum.setDamage(damage)

func getBelongsTo():
	return belongsTo

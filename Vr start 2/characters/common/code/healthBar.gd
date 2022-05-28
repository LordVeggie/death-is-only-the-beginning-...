extends TextureProgress

	
func updateHealthBar(val):
	value = val

func setMaxHealth(val):
	max_value = val

func _on_healthManager_health_changed(val):
	value = val

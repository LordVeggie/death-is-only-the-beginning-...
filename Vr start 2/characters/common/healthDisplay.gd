extends MeshInstance

onready var healthDisplayView = $healthDisplayView

func displayHealth():
	healthDisplayView.render_target_update_mode = Viewport.UPDATE_ONCE


func _on_healthManager_health_changed(val):
	displayHealth()

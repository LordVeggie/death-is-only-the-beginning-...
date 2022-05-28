extends CanvasLayer

signal changeLvToPlay

onready var nextLevelDoor = get_tree().get_nodes_in_group("nextLevelDoor")[0]

func _ready():
	connect("changeLvToPlay", nextLevelDoor, "setCurrentLevel")

func _on_lv1btn_pressed():
	emit_signal("changeLvToPlay", 0)


func _on_lv2btn_pressed():
	emit_signal("changeLvToPlay", 1)


func _on_Quitbtn_pressed():
	get_tree().quit()

extends CanvasLayer

onready var nextLevelDoor = get_tree().get_nodes_in_group("nextLevelDoor")[0]

func _ready():
	connect("changeLvToPlay", nextLevelDoor, "setCurrentLevel")

func _on_Quitbtn_pressed():
	get_tree().quit()


func _on_mainbtn_pressed():
	get_tree().change_scene("res://scenes/levels/lv"+str(0)+"/lv"+str(0)+".tscn")

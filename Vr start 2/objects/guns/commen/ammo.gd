extends "res://addons/godot-xr-tools/objects/Object_pickable.gd"

export (int) var ammoAmount = 1 setget setAmmoAmount, getAmmoAmount

func setAmmoAmount(amount):
	ammoAmount = amount

func getAmmoAmount():
	return ammoAmount

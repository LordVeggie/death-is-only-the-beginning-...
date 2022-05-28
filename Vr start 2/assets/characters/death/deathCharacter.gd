extends Spatial

onready var characterSkelleton = $"selleton armuture/Skeleton"
var leftPalm

# Called when the node enters the scene tree for the first time.
func _ready():
	leftPalm = characterSkelleton.find_bone("L PALM IK")
	if(leftPalm != null):
		print(leftPalm)


func setLeftPalm(transform):
	#var leftPalmTrans = characterSkelleton.get_bone_global_pose_no_override(leftPalm)
	#leftPalmTrans = transform
	#characterSkelleton.set_bone_custom_pose(leftPalm, transform)
	characterSkelleton.set_bone_global_pose_override(leftPalm, transform, 1, true)
	print(to_global(characterSkelleton.get_bone_global_pose(leftPalm).origin) == to_global(transform.origin))

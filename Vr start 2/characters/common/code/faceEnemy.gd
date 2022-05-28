extends Spatial

export var turnSpeed = 60.0 # max turn speed in degrees per second

func pointFace(enemyPos : Vector3, delta):
	var localPoint = to_local(enemyPos)
	localPoint.y = 0.0 # ignoring the heigh differince 
	var turnDirection = sign(localPoint.x) # tells us which way the ia should turn to give shortet turn amount
	var turnAmount = deg2rad(turnSpeed*delta) # amount to turn per frame 
	var angle = Vector3.FORWARD.angle_to(localPoint) #gets the angle between ai face and the enemy
	
	if(angle < turnAmount):
		turnAmount = angle
	rotate_object_local(Vector3.UP, -turnAmount * turnDirection) # turns the ai on its local axis

func isFacingTarget(enemyPos : Vector3):
	var localPoint = to_local(enemyPos)
	return localPoint.z < 0 and abs(localPoint.x) < 0.5

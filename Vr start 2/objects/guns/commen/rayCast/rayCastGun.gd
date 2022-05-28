extends "res://objects/guns/commen/gun.gd"

onready var shootPoint = $shootPoint

export (PackedScene) var bulletHitEffect = null

var bodieToExclude = []

func _ready():
	shootPoint.cast_to.z = -(gunRange)

func setBodieToExclud(bodies : Array):
	bodieToExclude = bodies

func shoot():
	
	shootPoint.force_raycast_update()
	
	if (shootPoint.is_colliding()):
		if(shootPoint.get_collider().has_method("hurt")):
			var damage = getDamage()
			shootPoint.get_collider().hurt(damage, shootPoint.get_collision_normal())
		
		if(shootPoint.get_collider().get_collision_layer_bit(0)):
			##hitting the enviornment and spawning damage marks
			var bulletHit = bulletHitEffect.instance()
			
			shootPoint.get_collider().add_child(bulletHit)
			
			bulletHit.global_transform.origin = shootPoint.get_collision_point()
			
			##rotate the hit effect so it points the correct way to be scene
			if(shootPoint.get_collision_normal().angle_to(Vector3.UP) < 0.00005):
				#do noting it is already correct 
				pass
			elif(shootPoint.get_collision_normal().angle_to(Vector3.DOWN) < 0.00005):
				bulletHit.rotate(Vector3.RIGHT, PI)
			else:
				
				var y = shootPoint.get_collision_normal().normalized()
				var x = y.cross(Vector3.UP)
				var z = x.cross(y)
				
				bulletHit.global_transform.basis = Basis(x, y, z).orthonormalized()

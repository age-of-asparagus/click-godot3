extends Node2D

export var Mob : PackedScene

func _on_SpawnTimer_timeout():
	var mob : KinematicBody2D = Mob.instance()
	
	# Choose a random location on Path2D.
	var mob_spawn_location : PathFollow2D = $ScreenEdgePath/MobSpawnLocation
	mob_spawn_location.offset = randi()
	
	mob.position = mob_spawn_location.position
	mob.rotation = mob_spawn_location.rotation
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Add some randomness to the direction (30 degrees either way)
	direction += rand_range(-PI / 6, PI / 6)
	mob.rotation = direction
	
	get_parent().add_child(mob)
	


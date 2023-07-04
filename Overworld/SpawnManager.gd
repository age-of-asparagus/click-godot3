extends Node2D

export var Mob : PackedScene
var screen_dimensions : Vector2

func _ready():
	screen_dimensions = get_viewport().get_visible_rect().size
	print(screen_dimensions)

func _on_SpawnTimer_timeout():
	var mob : KinematicBody2D = Mob.instance()
	
	get_parent().add_child(mob)
		
	mob.position = Vector2(rand_range(0, screen_dimensions.x), rand_range(0, screen_dimensions.y))
	


extends KinematicBody2D

export var speed := 50
export var health := 3
export var DeathEffect : PackedScene
export var XPNode : PackedScene
var velocity : Vector2

func _ready():
	# set speed in Y direction then rotate in random direction
	velocity = Vector2(speed, 0).rotated(rotation)
	$HealthStat.set_max_health(health)
	
func _physics_process(delta):
	move_and_slide(velocity)
	
	# Change direction if hit an obstacle
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = velocity.bounce(collision.normal)
			# Rotate the mob to face new movement direction
			rotation = velocity.angle()
	
func die():
	var parent = get_parent()
	
	var death_effect = DeathEffect.instance()
	parent.add_child(death_effect)
	death_effect.position = global_position

	var xpnode = XPNode.instance()
	parent.call_deferred("add_child", xpnode)
	xpnode.position = global_position
	
	queue_free()

func _on_WeaponDetector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.queue_free() # delete thing that hit mob
	$HealthStat.adjust_health(-area.damage)
	if $HealthStat.health <= 0:
		die()

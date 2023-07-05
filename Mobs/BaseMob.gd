extends KinematicBody2D

export var speed := 50
export var health := 3
export var DeathEffect : PackedScene
export var XPNode : PackedScene
var velocity

func _ready():
	# set speed in Y direction then rotate in random direction
	velocity = Vector2(speed, 0).rotated(rotation)
	$HealthStat.set_max_health(health)
	
func _physics_process(delta):
	move_and_slide(velocity)
	
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

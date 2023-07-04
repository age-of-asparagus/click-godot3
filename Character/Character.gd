extends KinematicBody2D

export var DeathEffect : PackedScene
export var BiteEffect : PackedScene
export var BiteMarkEffect : PackedScene

export var speed := 200
export var Ammo : PackedScene
export var max_health := 10
onready var health = max_health

var rotation_direction = 0
var movement_direction = 0
var target_rotation = 0
var velocity
var can_shoot = true

func _physics_process(delta):
	rotation = get_global_mouse_position().angle_to_point(position)
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	if velocity != Vector2.ZERO:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	move_and_slide(velocity)	
	
	if Input.is_action_pressed("shoot"):
		if can_shoot:
			shoot()


func shoot():
	if Global.stones >= 1:
		var projectile = Ammo.instance()
		get_parent().add_child(projectile)
		
		projectile.global_transform = $Hand.global_transform
		Global.stones -= 1
		can_shoot = false
		$FirerateTimer.start()
		
func die():
	var death_effect : Node2D = DeathEffect.instance()
	get_parent().add_child(death_effect)
	death_effect.position = global_position
	queue_free()
	
	

func _on_Detector_body_entered(body):
	
	var effect : Node2D = BiteEffect.instance()
	get_parent().add_child(effect)
	effect.position = body.global_position
	
	var bite_mark : Sprite = BiteMarkEffect.instance()
	add_child(bite_mark)
	var bite_position = body.global_position - (body.global_position - global_position)*0.7
	bite_mark.global_position = bite_position
	
	body.queue_free()
	
	health -= 1
	$HealthHUD.update_healthbar(health)
	if health <= 0:
		die()


func _on_Detector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.queue_free() # should only be XP nodes at this point...


func _on_FirerateTimer_timeout():
	can_shoot = true

extends Area2D



onready var mouse = get_parent().get_node("Mouse_area")
var clicked = false
var speed = 3
var fossil_label_position


func _physics_process(delta):
	if overlaps_area(mouse) == true:
		if Global.stick_stones_hover_mode == true:
			fossil_label_position = get_parent().get_node("CanvasLayer").get_node("fossil_panel/Position2D").global_position
			clicked = true
			$AnimationPlayer.play("size")
		else: if Input.is_action_just_pressed("click"):
			fossil_label_position = get_parent().get_node("CanvasLayer").get_node("fossil_panel/Position2D").global_position
			clicked = true
			$AnimationPlayer.play("size")
	
	if clicked == true:
		if speed <= 12:
			speed *= 1.05
		global_position += Vector2(fossil_label_position - global_position).normalized() * speed
		if fossil_label_position.distance_to(global_position) <= 50:
			Global.fossils += 1
			queue_free()

func _on_disappear_timer_timeout():
	if clicked == false:
		queue_free()



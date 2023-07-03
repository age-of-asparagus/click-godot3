extends TextureButton



onready var mouse = get_parent().get_node("Mouse_area")
var clicked = false
var speed = 3
var fossil_label_position


func _physics_process(delta):
	if $Area2D.overlaps_area(mouse) == true:
		if Global.Stick_Stones_hover_mode == true:
			fossil_label_position = get_parent().get_node("fossil_panel/Position2D").global_position
			clicked = true
			disabled = true
			$AnimationPlayer.play("size")

	
	if clicked == true:
		if speed <= 12:
			speed *= 1.05
		rect_global_position += Vector2(fossil_label_position - rect_global_position).normalized() * speed
		if fossil_label_position.distance_to(rect_global_position) <= 50:
			Global.Fossils += 1
			queue_free()

func _on_disappear_timer_timeout():
	if clicked == false:
		queue_free()


func _on_button_down():
	if Global.Stick_Stones_hover_mode == false:
		fossil_label_position = get_parent().get_node("fossil_panel/Position2D").global_position
		clicked = true
		disabled = true
		$AnimationPlayer.play("size")

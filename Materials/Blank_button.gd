extends TextureButton

onready var mouse = get_parent().get_node("Mouse_area")
var clicked = false
var speed = 3
var blank_label_position


func _physics_process(delta):
	if $Area2D.overlaps_area(mouse) == true:
		if Global.Stick_Stones_hover_mode == true:
			blank_label_position = get_parent().get_node("Blank_panel/Marker2D").global_position
			clicked = true
			disabled = true
			$AnimationPlayer.play("size")

	
	if clicked == true:
		if speed <= 12:
			speed *= 1.05
		rect_global_position += Vector2(blank_label_position - rect_global_position).normalized() * speed
		if blank_label_position.distance_to(rect_global_position) <= 50:
			Global.blanks += 1
			queue_free()

func _on_disappear_timer_timeout():
	if clicked == false:
		queue_free()


func _on_Blank_button_button_down():
	if Global.Stick_Stones_hover_mode == false:
		blank_label_position = get_parent().get_node("Blank_panel/Marker2D").global_position
		clicked = true
		disabled = true
		$AnimationPlayer.play("size")

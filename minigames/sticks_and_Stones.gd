extends Node2D

var Stick = preload("res://Materials/Stick_button.tscn")
var Stone = preload("res://Materials/Stone_button.tscn")
var Fossil = preload("res://Materials/Fossil_button.tscn")

var transitioning = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _physics_process(delta):
	$Mouse_area/CollisionShape2D.scale = Vector2(Global.Stick_Stones_magnet_size, Global.Stick_Stones_magnet_size)
	$Mouse_area/CollisionShape2D.global_position = get_global_mouse_position()
	get_node("stone_panel/Label").set_text("x" + str(Global.stones))
	get_node("stick_panel/Label").set_text("x" + str(Global.sticks))
	get_node("fossil_panel/Label").set_text("x" + str(Global.Fossils))
	

func _on_fossil_spawn_timer_timeout():
	if rng.randi_range(0,100) <= 1:
		var fossil = Fossil.instance()
		add_child(fossil)
		fossil.rect_global_position = Vector2(rng.randi_range(100,560), rng.randi_range(50,350))
		fossil.rect_rotation = rng.randi_range(0,360)
	$fossil_spawn_timer.wait_time = 1 * Global.Stick_Stones_spawn_rate
	$fossil_spawn_timer.start()


	
func _on_stone_spawn_timer_timeout():
	if rng.randi_range(0,100) <= 30:
		var stone = Stone.instance()
		add_child(stone)
		stone.rect_global_position = Vector2(rng.randi_range(100,560), rng.randi_range(50,350))
		stone.rect_rotation = rng.randi_range(0,360)
	$stone_spawn_timer.wait_time = rng.randf_range(0.25,1.5) * Global.Stick_Stones_spawn_rate
	$stone_spawn_timer.start()

func _on_stick_spawn_timer_timeout():
	if rng.randi_range(0,100) <= 60:
		var stick = Stick.instance()
		add_child(stick)
		stick.rect_global_position = Vector2(rng.randi_range(100,560), rng.randi_range(50,350))
		stick.rect_rotation = rng.randi_range(0,360)
	$stick_spawn_timer.wait_time = rng.randf_range(0.2,1.25) * Global.Stick_Stones_spawn_rate
	$stick_spawn_timer.start()


func _on_Upgrades_button_down():
		if transitioning == false:
			transitioning = true
			$AnimationPlayer.play("Camera_transition")
			yield($AnimationPlayer, "animation_finished")
			transitioning = false


func _on_Overworld_button_down():
	get_tree().change_scene_to_file("res://Overworld.tscn")


func _on_Back_button_down():
		if transitioning == false:
			transitioning = true
			$AnimationPlayer.play("Camera_transition_back")
			yield($AnimationPlayer, "animation_finished")
			transitioning = false


func _on_Hover_mode_button_down():
	Global.Stick_Stones_hover_mode = true


func _on_Spawn_rate_button_down():
	if Global.Stick_Stones_spawn_rate >= 0.02:
		Global.Stick_Stones_spawn_rate -= 0.01



func _on_Magnet_size_button_down():
	Global.Stick_Stones_magnet_size += .05



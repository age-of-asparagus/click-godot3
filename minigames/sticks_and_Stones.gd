extends Node2D

var stick_value = 1
var stone_value = 2
var fossil_value = 100

var Stick = preload("res://Materials/Stick_button.tscn")
var Stone = preload("res://Materials/Stone_button.tscn")
var Fossil = preload("res://Materials/Fossil_button.tscn")

var transitioning = false
var rng = RandomNumberGenerator.new()

func _ready():
	get_node("CanvasLayer/fossil_panel/sell_amount").visible = false
	get_node("CanvasLayer/fossil_panel/fossil_sell_amount").visible = false
	get_node("CanvasLayer/stick_panel/sell_amount").visible = false
	get_node("CanvasLayer/stick_panel/stick_sell_amount").visible = false
	get_node("CanvasLayer/stone_panel/sell_amount").visible = false
	get_node("CanvasLayer/stone_panel/stone_sell_amount").visible = false
	rng.randomize()

func _physics_process(delta):
	get_node("Fossil_panel/token_amount").text = String(Global.stick_stone_tokens)
	
	get_node("CanvasLayer/stone_panel/sell_amount").max_value = Global.stones
	get_node("CanvasLayer/stone_panel/stone_sell_amount").text = String(get_node("CanvasLayer/stone_panel/sell_amount").value)
	
	get_node("CanvasLayer/stick_panel/sell_amount").max_value = Global.sticks
	get_node("CanvasLayer/stick_panel/stick_sell_amount").text = String(get_node("CanvasLayer/stick_panel/sell_amount").value)
	
	get_node("CanvasLayer/fossil_panel/sell_amount").max_value = Global.fossils
	get_node("CanvasLayer/fossil_panel/fossil_sell_amount").text = String(get_node("CanvasLayer/fossil_panel/sell_amount").value)
	
	if get_node("CanvasLayer/stick_panel/sell_amount").value + get_node("CanvasLayer/fossil_panel/sell_amount").value + get_node("CanvasLayer/stone_panel/sell_amount").value >= 1:
		get_node("sell_button").visible = true
	else:
		get_node("sell_button").visible = false
	
	if Global.Stick_Stones_magnet_size >= 1.5:
		$Mouse_area/Magnet_effect.scale = Vector2(Global.Stick_Stones_magnet_size, Global.Stick_Stones_magnet_size) 
	$Mouse_area/Magnet_effect.global_position = get_global_mouse_position()
	$Mouse_area/CollisionShape2D.scale = Vector2(Global.Stick_Stones_magnet_size, Global.Stick_Stones_magnet_size)
	$Mouse_area/CollisionShape2D.global_position = get_global_mouse_position()
	$CanvasLayer.get_node("stone_panel/stone_amount").set_text("x" + str(Global.stones))
	$CanvasLayer.get_node("stick_panel/stick_amount").set_text("x" + str(Global.sticks))
	$CanvasLayer.get_node("fossil_panel/fossil_amount").set_text("x" + str(Global.fossils))
	

func _on_fossil_spawn_timer_timeout():
	if rng.randf_range(0,100) <= 0.5:
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
	get_tree().change_scene("res://Overworld/Overworld.tscn")


func _on_Back_button_down():
		if transitioning == false:
			transitioning = true
			$AnimationPlayer.play("Camera_transition_back")
			yield($AnimationPlayer, "animation_finished")
			transitioning = false


func _on_Hover_mode_button_down():
	if Global.stick_stone_tokens >= Global.hover_mode_price and Global.Stick_Stones_hover_mode == false:
		Global.stick_stone_tokens -= Global.hover_mode_price
		Global.Stick_Stones_hover_mode = true


func _on_Spawn_rate_button_down():
	if Global.Stick_Stones_spawn_rate >= 0.02 and Global.stick_stone_tokens >= Global.spawn_rate_upgrade_price:
		Global.stick_stone_tokens -= Global.spawn_rate_upgrade_price
		Global.spawn_rate_upgrade_price = round(Global.spawn_rate_upgrade_price * 1.075)
		Global.Stick_Stones_spawn_rate -= 0.01



func _on_Magnet_size_button_down():
	if Global.stick_stone_tokens >= Global.magnet_upgrade_price:
		Global.stick_stone_tokens -= Global.magnet_upgrade_price
		Global.magnet_upgrade_price = round(Global.magnet_upgrade_price * 1.05)
		Global.Stick_Stones_magnet_size += .05




func _on_sell_button_button_down():
	Global.stones -= get_node("CanvasLayer/stone_panel/sell_amount").value
	Global.sticks -= get_node("CanvasLayer/stick_panel/sell_amount").value
	Global.fossils -= get_node("CanvasLayer/fossil_panel/sell_amount").value
	Global.stick_stone_tokens += get_node("CanvasLayer/stone_panel/sell_amount").value * stone_value + get_node("CanvasLayer/stick_panel/sell_amount").value * stick_value + get_node("CanvasLayer/fossil_panel/sell_amount").value * fossil_value
	get_node("CanvasLayer/stone_panel/sell_amount").value = 0
	get_node("CanvasLayer/stick_panel/sell_amount").value = 0
	get_node("CanvasLayer/fossil_panel/sell_amount").value = 0
	
	
	
	
	
	
	
	
	
	
	

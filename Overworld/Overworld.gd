extends Node2D

var player_is_near := false

func _process(delta):
	if player_is_near:
		$ClickArea/KeyPrompt.visible = true
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene("res://minigames/sticks_and_Stones.tscn")
	else:
		$ClickArea/KeyPrompt.visible = false
	
	if Input.is_action_just_pressed("1"):
		$Character.set_item_index(0)
		$HUD/ItemList.select(0)
		
	if Input.is_action_just_pressed("2"):
		$Character.set_item_index(1)
		$HUD/ItemList.select(1)
		
	if Input.is_action_just_pressed("restart"):
		Global.stones = 100
		Global.sticks = 100
		get_tree().reload_current_scene()

func _on_ClickArea_body_entered(body):
	player_is_near = true
	
func _on_ClickArea_body_exited(body):
	player_is_near = false

extends Node2D

var player_is_near := false

func _process(delta):
	if player_is_near:
		$ClickArea/KeyPrompt.visible = true
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene("res://minigames/sticks_and_Stones.tscn")
	else:
		$ClickArea/KeyPrompt.visible = false
	
	# loop through each of the hotbar hotkeys to see if pressed
	for i in range(0, $HUD/ItemList.get_item_count()):
		# each number key is mapped to an action, e.g. keypad 1 is mapped to action "1".
		# so for the first i=0, we add 1 and convert to a string to get "1"
		if Input.is_action_just_pressed(str(i+1)):
			if not $HUD/ItemList.is_item_disabled(i):
				$Character.set_item_index(i)
				$HUD/ItemList.select(i)
			else:
				print("Item " + str(i+1) + " is not enabled yet")

	if Input.is_action_just_pressed("restart"):
		Global.stone.count = 100
		Global.stick.count = 100
		get_tree().reload_current_scene()

func _on_ClickArea_body_entered(body):
	player_is_near = true
	
func _on_ClickArea_body_exited(body):
	player_is_near = false

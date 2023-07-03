extends Node2D



func _on_ClickArea_body_entered(body):
	# change scenes
	
	get_tree().change_scene("res://minigames/sticks_and_Stones.tscn")

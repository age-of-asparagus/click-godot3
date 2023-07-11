extends Node2D

var MiniGameScene = preload("res://minigames/sticks_and_Stones.tscn")
onready var player = $Transition/AnimationPlayer

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		Global.stone.count = 100
		Global.stick.count = 100
		Global.fossil.count = 100
		get_tree().reload_current_scene()

func transition(to_minigame : bool = true):
	if to_minigame:
		Global.set_pause_tree($Overworld, true)
	
	player.play("TransitionOut")
	yield(player, "animation_finished")
	
	# add minigame during transition animation
	if to_minigame:
		var scene = MiniGameScene.instance()
		add_child(scene)
	
	player.play_backwards("TransitionOut")
	
	if not to_minigame:
		Global.set_pause_tree($Overworld, false)

func _on_Overworld_transition():
	transition()

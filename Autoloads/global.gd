extends Node

class GameItemData:
	var label : String
	var count : int
	var texture : Texture
	var packed_scene : PackedScene
	
	func _init(label, count, texture, packed_scene):
		self.label = label
		self.count = count
		self.texture = texture
		self.packed_scene = packed_scene
		
var stick = GameItemData.new(
		"Stick", 
		20, 
		load("res://Assets/Stick_material_32px.png"),
		preload("res://Items/Stick.tscn")
	)
var stone = GameItemData.new(
		"Stone", 
		0, 
		load("res://Assets/Stone_material_32px.png"),
		preload("res://Items/Stone.tscn")
	)
var fossil = GameItemData.new(
		"Fossil", 
		0, 
		load("res://Assets/Fossil_material-1.png (2).png"),
		preload("res://Items/Fossil.tscn")
	)

var items = {
	stick.label: stick,
	stone.label: stone,
	fossil.label: fossil
}



var stick_stone_tokens = 0

var stick_stones_spawn_amount = 1
var stick_stone_spawn_amount_upgrade_price = 100
var stick_stone_spawn_amount_level = 0

var stick_stones_magnet_size = 1
var stick_stone_magnet_upgrade_price = 30
var stick_stone_magnet_level = 0

var stick_stones_spawn_rate = 1
var stick_stone_spawn_rate_upgrade_price = 10
var stick_stone_spawn_rate_level = 0

var stick_stones_hover_mode = false
var stick_stone_hover_mode_price = 1000

func set_pause_node(node : Node, pause : bool) -> void:
	node.set_physics_process(!pause)
	node.set_process(!pause)
	node.set_process_input(!pause)
	node.set_process_unhandled_input(!pause)
	node.set_process_unhandled_key_input(!pause)
	
	if node is Timer:
		node.paused = pause
		
	if node is AnimationPlayer:
		if pause:
			node.stop(false)  # false means pause at current frame
		else:
			node.play()
			
	if node is AnimatedSprite:
		if pause:
			node.stop()
		else:
			node.play()
		
	
func set_pause_tree(rootNode : Node, pause : bool, ignoredChilds : PoolStringArray = [null]):
		set_pause_node(rootNode, pause)
		for node in rootNode.get_children():
			if not (String(node.get_path()) in ignoredChilds):
				set_pause_tree(node, pause, ignoredChilds)

extends Node2D

""" USAGE
To use this node, drop it under a node that you want to have health tracked with a health bar.

When the node should lose health, call:
	 $Healthstat.adjust_health(value)

`value` is the amount of health to lose (if negative) or gain
	
"""

export var max_health := 1
onready var health = max_health setget set_health

var bar_red = preload("res://Assets/Downloaded/barHorizontal_red.png")
var bar_green = preload("res://Assets/Downloaded/barHorizontal_green.png")
var bar_yellow = preload("res://Assets/Downloaded/barHorizontal_yellow.png")

onready var healthbar = $HealthBar

func set_max_health(value):
	max_health = value
	health = max_health
	healthbar.max_value = max_health
	_update_healthbar()
	
func set_health(value):
	health = value
	_update_healthbar()

func _ready():
	hide()  # invisible when full health
	healthbar.max_value = max_health
		
func _process(delta):
	# Prevent bar from rotating with unit
	global_rotation = 0

func _update_healthbar():
	healthbar.texture_progress = bar_green
	if health < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if health < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if health < healthbar.max_value:
		show()
	healthbar.value = health
	
func adjust_health(value):
	var new_health = health + value
	self.health = min(new_health, max_health)


extends Node

export var margin_pixels := 50
onready var viewport_rect : Rect2 = get_viewport().get_visible_rect().grow(margin_pixels)
onready var parent = get_parent()

func _process(delta):
	# remove the parent node if they go margin_pixels off screen
	if not viewport_rect.has_point(parent.position):
		parent.queue_free()

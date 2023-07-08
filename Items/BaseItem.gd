extends Area2D

class_name GameItem

export var label := "Item"
export var damage := 1
export var destroy_on_contact := true
export var speed := 500
export var max_distance := 1000
export var is_pickupable := true
export var lifetime_seconds := 2
export var rotation_speed := 10
export var randomness := 0.2

export var texture_scale := 1.0

var age_seconds := 0.0

onready var initial_position = global_position

func _ready():
	$Sprite.texture = Global.items[label].texture
	$Sprite.scale = Vector2(texture_scale, texture_scale)
	
	# add a little bit of randomness to rotation and distance and speed
	# so they don't all line up
	lifetime_seconds *= rand_range(1.0-randomness, 1.0+randomness)
	max_distance *= rand_range(1.0-randomness, 1.0+randomness)
	rotation_speed *= rand_range(1.0-randomness, 1.0+randomness)
	speed *= rand_range(1.0-randomness, 1.0+randomness)
	
	rotation += rand_range(randomness/2.0, -randomness/2.0)
	

func _physics_process(delta):
	
	# track the item's age since creation
	age_seconds += delta
	if age_seconds > lifetime_seconds:
		queue_free()
		
	# only move and rotate if distance travelled is less than max
	if (global_position - initial_position).length() < max_distance:
		position += transform.x * speed * delta
		$Sprite.rotation += rotation_speed * delta
	else:
		# Not longer acting as a weapon, so turn off the "Weapon" collision layer
		set_collision_layer_bit(2, false)
		if is_pickupable:
			# Turn on collectable layer
			set_collision_layer_bit(4, true)

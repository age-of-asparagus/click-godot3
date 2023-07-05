extends Area2D

export var damage := 1
export var speed := 500
export var max_distance := 1000
export var lifetime_seconds := 2
export var rotation_speed := 10

export var texture_scale := 1.0
export(Texture) var texture  

var age_seconds := 0.0

onready var initial_position = global_position

func _ready():
	$Sprite.texture = texture
	$Sprite.scale = Vector2(texture_scale, texture_scale)

func _physics_process(delta):
	
	# track the item's age since creation
	age_seconds += delta
	if age_seconds > lifetime_seconds:
		queue_free()
		
	# only move and rotate if distance travelled is less than max
	if (global_position - initial_position).length() < max_distance:
		position += transform.x * speed * delta
		$Sprite.rotation += rotation_speed * delta
	

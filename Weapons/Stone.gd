extends Area2D

export var speed := 500
export var rotation_speed := 10

func _physics_process(delta):
	position += transform.x * speed * delta
	$StoneMaterial.rotation += rotation_speed * delta

func _on_Timer_timeout():
	queue_free()

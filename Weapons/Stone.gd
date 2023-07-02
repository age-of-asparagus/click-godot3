extends Area2D

export var speed := 500

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Timer_timeout():
	queue_free()

extends Node2D
var is_fading := false
var fade_alpha := 1.0
export var fade_speed := 1

func _ready():
	$CPUParticles2D.emitting = true
	
func _process(delta):
	if is_fading:
		fade_alpha -= fade_speed * delta
		fade_alpha = max(fade_alpha, 0)
		print(fade_alpha)

		# Set the particles' color and alpha
		var particles_color : Color = $CPUParticles2D.color
		particles_color.a = fade_alpha
		$CPUParticles2D.color = particles_color
		print($CPUParticles2D.color)

		# Check if the fade-out animation is completed
		if fade_alpha <= 0:
			queue_free()

func _on_Timer_timeout():
	print("Fading")
	is_fading = true

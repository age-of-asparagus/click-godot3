extends CPUParticles2D

var is_fading := false
var fade_alpha := 1.0
export var fade_speed := 1.0

func _ready():
	emitting = true
	
func _process(delta):
	if is_fading:
		fade_alpha -= fade_speed * delta
		fade_alpha = max(fade_alpha, 0)

		# Set the particles' color and alpha
		var particles_color : Color = color
		particles_color.a = fade_alpha
		color = particles_color

		# Check if the fade-out animation is completed
		if fade_alpha <= 0:
			queue_free()

func _on_Timer_timeout():
	is_fading = true

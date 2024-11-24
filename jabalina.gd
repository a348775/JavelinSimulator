extends RigidBody2D # Jabalina

onready var d = 0 # distance

func _ready():
	visible = false
	set_deferred("mode", MODE_KINEMATIC) # turn-off physics
	# warning-ignore:return_value_discarded
	$"../gamer".connect("throw", self, "_throw") # gamer signal to shot
	var r = $image.rotation
	$efecto.playback_speed = 1.25
	$efecto.repeat = 2
	$efecto.interpolate_property($image, 'rotation',
		r+0.03, r-0.03, 0.25, Tween.TRANS_BOUNCE, Tween.EASE_OUT) # Tween.TRANS_SINE
	
func _throw(impulse, angle, pos):
	set_position(pos + Vector2(-30, -90)) # Configurar posición y ángulo
	if angle >= 0:  # Limitar el ángulo máximo
		if angle < 3:
			angle = 3
	elif angle > -3:  # Limitar el ángulo mínimo
		angle = -3
	rotate(angle)  # Rotar la jabalina
	mode = MODE_RIGID  # Activar física
	
	# Aumentar la velocidad del lanzamiento
	impulse *= 1.8
	
	add_torque(900)  # Fuerza angular (puedes aumentarlo si deseas más rotación)
	visible = true  # Mostrar jabalina
	apply_central_impulse(impulse)  # Lanzar: aplicar la fuerza


# warning-ignore:unused_argument
func _on_jabalina_body_entered(body):
	if body.name == 'suelo':
		$sound.play()
		$particle.hide()
		set_deferred("mode", MODE_KINEMATIC) # turn-off physics
		pause_mode = true
		$efecto.start()
		$pausa.start()
		d = round(max(0,position.x - 465)/10)
		$distance.text = str(d) + " m"

func _on_pausa_timeout(): # Al finalizar el lanzamiento
	if Score.update_intento(d): # Actualizar intentos y vidas
		Score.change_level()
	$".".get_tree().reload_current_scene()


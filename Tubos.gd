extends RigidBody2D

onready var tween = $Tween
onready var start_position = position.y
onready var move_range = 50  # Rango de movimiento vertical
onready var move_duration = 2.0  # Duración del movimiento

func _ready():
	start_movement()

func start_movement():
	# Configura el movimiento hacia abajo
	tween.interpolate_property(self, "position:y", start_position, start_position + move_range, move_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	# Configura el movimiento hacia arriba después
	tween.interpolate_property(self, "position:y", start_position + move_range, start_position, move_duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT, move_duration)
	# Repite el movimiento constantemente
	tween.start()
	tween.connect("tween_completed", self, "_on_tween_completed")

func _on_tween_completed(object, key):
	# Reinicia el movimiento en bucle
	tween.start()

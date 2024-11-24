extends RigidBody2D

onready var tween = $Tween
export var move_distance = 200  # Distancia de movimiento hacia arriba y abajo
export var move_duration = 2.5  # Tiempo de ida o vuelta (segundos)

func _ready():
	start_movement()

func start_movement():
	# Define las posiciones de inicio y destino
	var start_pos = position
	var end_pos = position + Vector2(0, move_distance)
	
	# Configura el movimiento del Tween
	tween.interpolate_property(self, "position", start_pos, end_pos, move_duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	# Reversa el movimiento cuando termine
	tween.connect("tween_completed", self, "_on_tween_completed")

func _on_tween_completed(_object, _key):
	# Cambia la dirección cada vez que se completa el movimiento
	move_distance = -move_distance
	start_movement()

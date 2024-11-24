extends Area2D  # Cambiado a Area2D

export var speed_boost = 2.0  # Factor de aumento de velocidad
export var movement_speed = 80.0  # Velocidad de movimiento hacia arriba y abajo
export var movement_range = 150.0  # Rango de movimiento vertical

var javelin = null
var original_position = Vector2()

func _ready():
	# Encuentra la jabalina en la escena
	javelin = get_parent().get_node("jabalina")

	# Guarda la posición original del potenciador
	original_position = position

func _process(delta):
	# Movimiento oscilante hacia arriba y abajo
	position.y = original_position.y + (sin(OS.get_ticks_msec() / 500.0) * movement_range)

func _on_Potenciador_body_entered(body):
	if body.name == "jabalina":  # Asegúrate de que el nombre coincida
		apply_speed_boost()

func apply_speed_boost():
	# Aumenta la velocidad de la jabalina
	javelin.linear_velocity *= speed_boost  # Multiplica la velocidad actual
	queue_free()  # Destruye el potenciador después de usarse

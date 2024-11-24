extends Area2D

export var score_multiplier = 2  # Multiplicador de puntaje
export var radius = 150.0  # Radio del movimiento circular
export var speed = 6.0  # Velocidad del movimiento circular

var original_position = Vector2()
var angle = 0.0

func _ready():
	original_position = position  # Guarda la posición inicial para el movimiento
	connect("body_entered", self, "_on_Area2D_body_entered")  # Conecta la señal de colisión

func _process(delta):
	# Movimiento circular
	angle += speed * delta
	position.x = original_position.x + cos(angle) * radius
	position.y = original_position.y + sin(angle) * radius


func _on_Multiplicadorr_body_entered(body):
	# Verifica si el cuerpo que entra en contacto es la jabalina
	if body.name == "jabalina":
		# Duplica el puntaje total en el script de Score
		Score.score *= score_multiplier  
		queue_free()  # Elimina el multiplicador después de activarse

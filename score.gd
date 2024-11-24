extends CanvasLayer

onready var nivel = 0
onready var intentos = 5
onready var score = 0
onready var tiempo = 0
onready var vidas = 3

func _process(_delta):
	$info.text = "Nivel: " + str(nivel) + "\n" + \
		"Vidas: " + str(vidas) + "\n" + \
		"Intentos: " + str(intentos) + "\n" + \
		"Score: " + str(score) + "\n" + \
		"Tiempo: " + str(round($tiempo.time_left))

func update_intento(d, invalido=false):
	if invalido: # Tiro inválido
		vidas -= 1
		intentos -= 1 # Se pierde también un intento
		if vidas <= 0: # Verifica si se acabaron las vidas
			desactivar_marcador()
			get_tree().change_scene("res://Final.tscn")
			return true
	elif intentos > 0: # Tiro válido
		score += (d * 10)
		intentos -= 1
		if intentos < 1: # Se acabaron los intentos
			vidas -= 1
			if vidas <= 0:
				desactivar_marcador()
				get_tree().change_scene("res://Final.tscn")
				return true
			else:
				intentos = 5 # Reinicia los intentos para el siguiente nivel
				if nivel == 3: # Si es el nivel 3, pasa al final
					desactivar_marcador()
					get_tree().change_scene("res://Final.tscn")
					return true
				else: # Si no es el último nivel, pasa al siguiente nivel
					change_level()
					return true
	return false



func change_level():
	nivel += 1
	intentos = 5 # Reinicia los intentos a 5 cada vez que se cambie de nivel
	
	if nivel <= 3: # Cambia a los niveles 1..3
		$".".visible = true # Mostrar marcador
		get_tree().change_scene("res://Nivel" + str(nivel) + ".tscn")
	else:
		$".".visible = false # Ocultar marcador
		get_tree().change_scene("res://Final.tscn") # Pantalla de final


func _on_tiempo_timeout(): # Al terminar el tiempo
	if nivel == 3: # Si es el nivel 3
		desactivar_marcador()
		get_tree().change_scene("res://Final.tscn")
	else:
		change_level()
		
func desactivar_marcador():
	$info.visible = false # Oculta el marcador
	$tiempo.stop() # Detiene el temporizador
	set_process(false) # Detiene el procesamiento del marcador

func reset_game():
	nivel = 0
	vidas = 3
	intentos = 5
	score = 0
	tiempo = 0

func _on_go_pressed():
	change_level()

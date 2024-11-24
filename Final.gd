# Final
extends Node2D

func _ready():
	$score.text += str(Score.score)

func _on_salir_pressed():
#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().quit()


func _on_Regresar_pressed():
	Score.reset_game() # Reinicia el marcador y variables globales
	get_tree().change_scene("res://MenuPrincipal.tscn") # Cambia al menú principal

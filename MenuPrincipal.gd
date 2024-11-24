extends Node2D

func _on_iniciar_pressed():
	Score.reset_game() # Reinicia el marcador y variables globales
	Score.change_level()

func _on_Salir_pressed():
	get_tree().quit()

func _on_Creditos_pressed():
	get_tree().change_scene("res://Creditos.tscn")

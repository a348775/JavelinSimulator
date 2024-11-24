extends Node2D

func _on_pausa_timeout():
	get_tree().change_scene("res://MenuPrincipal.tscn")


func _on_go_pressed():
	get_tree().change_scene("res://MenuPrincipal.tscn")


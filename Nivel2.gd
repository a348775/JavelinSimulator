# Nivel2
extends Node2D

#func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	$camera.position = $jabalina.position

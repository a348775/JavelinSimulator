# Nivel1
extends Node2D

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$jabalina/particle.emitting = false # javaline particles = off

func _process(_delta):
	$camera.position = $jabalina.position

extends RigidBody2D # Gamer

signal throw(impulse, angle, pos) # signal for javaline

enum GamerState { READY, DRAG, SHOT } # mouse drag state

const DUR_MIN = 50
const DUR_MAX = 1000

onready var state = GamerState.READY

var drag_start # start position
var time_start # start running time-stamp
onready var vida_perdida = false

func _ready():
	set_pickable(true) # draggable
	set_process(true)

func verif(pos): # Checar línea de tiro
	var r = ((pos.x + 300) >= 730) # Si pasa la línea
	if r:
		if not $alarm.playing: # Evitar múltiples decrementos por un mismo tiro
			$alarm.play(1)
			$anime.stop()
			$anime.self_modulate.a = 0.45 # Jugador semi-transparente
			Score.update_intento(0, true) # Tiro inválido, se pierde una vida
	return r




func _process(_delta):
	var pos = get_viewport().get_mouse_position()
	position.x = clamp(pos.x, 20, 550)
	if Input.is_action_pressed("click") and state!=GamerState.SHOT: # dragging?
		if state == GamerState.DRAG: # moving
			if verif(pos):
				state = GamerState.READY
		else: # start drag
			$anime.play("run")
			drag_start = pos # posicion inicial
			time_start = Time.get_ticks_msec()
			state = GamerState.DRAG
	elif state == GamerState.DRAG and not $alarm.playing: # end: throw
			var dur = Time.get_ticks_msec() - time_start
			dur = clamp(dur, DUR_MIN, DUR_MAX) 		# min to max duration
			dur = range_lerp(dur, DUR_MIN, DUR_MAX, 0.5, 3.5) # speed range
			var distance = pos - drag_start # final - initial position
			var impulse = distance / dur		# impulse speed
			$anime.play("fire")				# throw animation
			state = GamerState.SHOT			# shot state
			var angle = drag_start.angle_to_point(pos) # calcula angulo
			yield($anime, "animation_finished") # wait for "fire" end-of-animation
			emit_signal("throw", impulse, angle, pos) # lanzar jabalina
			$anime.play("after")

func _on_alarm_finished(): # passing the line...
	# warning-ignore:return_value_discarded
	$".".get_tree().reload_current_scene()


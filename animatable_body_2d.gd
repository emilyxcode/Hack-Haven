extends CharacterBody2D

@export var amplitude: float = 50.0  # How high/low it goes from the center
@export var frequency: float = 0.1   # How fast it oscillates

var start_y: float

func _ready() -> void:
	start_y = global_position.y

func _physics_process(delta: float) -> void:
	# Sinusoidal motion up and down
	var time = Time.get_ticks_msec() / 1000.0
	global_position.y = start_y + sin(time * frequency * TAU) * amplitude

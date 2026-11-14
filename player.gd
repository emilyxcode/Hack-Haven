extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 250.0
const JUMP_VELOCITY = -300.0

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		animated_sprite.play("default")
	var direction := Input.get_axis("left", "right")
	if direction == -1:
		animated_sprite.flip_h = true
		animated_sprite.play("default")
	if direction == 1:
		animated_sprite.flip_h = false
		animated_sprite.play("default")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if global_position.y > 600:
		get_tree().reload_current_scene()
func die() -> void:
	get_tree().reload_current_scene()

extends CharacterBody2D

@export var follow_speed: float = 200.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var player: Node2D = null
var is_following: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	$Area2D.body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		await get_tree().create_timer(1).timeout
		is_following = true

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Chase player
	if is_following and is_instance_valid(player):
		var direction_x = sign(player.global_position.x - global_position.x)
		velocity.x = direction_x * follow_speed

		animated_sprite.play("run")
		if direction_x != 0:
			animated_sprite.flip_h = direction_x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, follow_speed)

	# Move chicken
	move_and_slide()

	# Kill player on contact
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is CharacterBody2D and body.name == "Player":
			body.die()
			return

extends CharacterBody2D

var player: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Je_sprite
var speed := 700.0
var screen_size: Vector2
var direction := Vector2.ZERO
var is_waiting := false
var is_foncing := false

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	screen_size = get_viewport_rect().size
	print("player =", player)
	sprite.play()
	sprite.animation = "default"
	preparer_fonce()
 
func preparer_fonce() -> void:
	if player == null:
		return
	is_foncing = false
	is_waiting = true
	velocity = Vector2.ZERO
	sprite.animation = "default"
	await get_tree().create_timer(0.5).timeout
	direction = global_position.direction_to(player.global_position)
	is_foncing = true
	is_waiting = false

func _physics_process(delta: float) -> void:
	if player == null:
		return

	if is_foncing:
		velocity = direction * speed
		move_and_slide()

		if is_on_wall() or is_on_ceiling() or is_on_floor():
			is_foncing = false
			is_waiting = true
			velocity = Vector2.ZERO
			sprite.animation = "damage"
			print("touche le mur, attente 0.5s")
			await get_tree().create_timer(0.5).timeout
			preparer_fonce()

	global_position = global_position.clamp(Vector2.ZERO, screen_size)

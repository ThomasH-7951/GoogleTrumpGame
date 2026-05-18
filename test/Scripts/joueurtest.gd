extends CharacterBody2D



const SPEED = 300.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right",)
	$AnimatedSprite2D.play()
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var directiony := Input.get_axis("ui_up", "ui_down",)
	$AnimatedSprite2D.play()
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
	else :
		$AnimatedSprite2D.animation = "idle"
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()

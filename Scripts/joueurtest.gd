extends CharacterBody2D



const SPEED = 300.0
var screen_size

# systeme de degat / pv

@export var Coeur_Plein : Texture2D
@export var Coeur_Vide : Texture2D
const max_hp = 3
var hp = 3 :
	set(value):
		hp = value
		update_coeurs()
		if hp <= 0:
			print("game over !") 
			
var can_take_damage = true

func _ready():
	screen_size = get_viewport_rect().size
	update_coeurs()  
	

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
	elif velocity.y	 < 0:
		$AnimatedSprite2D.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
	else :
		$AnimatedSprite2D.animation = "idle"
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	for zone in $Zone_Colision_Joueur.get_overlapping_areas():
		if zone.is_in_group("Zone_Degats") and can_take_damage :
			hp -= 1
			print("touché ! hp : ", hp)
			can_take_damage = false
			await get_tree().create_timer(1.0).timeout
			can_take_damage = true

func update_coeurs():
	$CanvasLayer/Coeur1.texture = Coeur_Plein if hp >= 1 else Coeur_Vide
	$CanvasLayer/Coeur2.texture = Coeur_Plein if hp >= 2 else Coeur_Vide
	$CanvasLayer/Coeur3.texture = Coeur_Plein if hp >= 3 else Coeur_Vide

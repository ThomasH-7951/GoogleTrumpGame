extends CharacterBody2D



const SPEED = 1000
var screen_size

# systeme de degat / pv

@export var Coeur_Plein : Texture2D
@onready var menu = preload("res://Menus/Start_Menu/Menu.tscn") 
@export var Coeur_Vide : Texture2D
const max_hp = 3

var hp = 3
@onready var death_screen = $"../DeathScreen"
func game_over():
	can_move = false
	can_take_damage = false
	get_tree().paused = true
	death_screen.show()
	
#get_tree().change_scene_to_file.bind("res://Scenes/DeathScreen.tscn").call_deferred()
#get_node("res://Scenes/DeathScreen.tscn/DS_audio").play()
@onready var projectile_scene = preload ("res://Jeu/Joueur/Projectiles/Projectile-Joueur.tscn")
@onready var Shooting_Point = $ShootingPoint
var last_direction = Vector2.RIGHT
var can_shoot = true
var can_take_damage = true
var can_move = true


func _ready():
	
	add_to_group("player")
	screen_size = get_viewport_rect().size
	$playersprite.play()
	update_coeurs()  
	print(menu)
func clignoter() -> void:
		for i in 8:
			$playersprite.modulate.a = 0.2
			await get_tree().create_timer(0.05, false).timeout
			$playersprite.modulate.a = 1.0
			await get_tree().create_timer(0.05, false).timeout

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if can_move :
		var directionx := Input.get_axis("ui_left", "ui_right",)
		
		if directionx:
			velocity.x = directionx * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		var directiony := Input.get_axis("ui_up", "ui_down",)
		
		if directiony:
			velocity.y = directiony * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			
		if velocity.x > 0:
			$playersprite.animation = "walk"
			$playersprite.flip_h = false
		elif velocity.x < 0:
			$playersprite.animation = "walk"    
			$playersprite.flip_h = true
		elif velocity.y < 0:
			$playersprite.animation = "up"
		elif velocity.y > 0:
			$playersprite.animation = "down"
		else:
			$playersprite.animation = "idle"
		
		move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			#print("j_touché :", collision.get_collider().name)
		global_position = global_position.clamp(Vector2.ZERO, screen_size)	
	for zone in $Zone_Colision_Joueur.get_overlapping_areas():
		if !is_instance_valid(zone):
			continue
		if zone.is_in_group("Zone_Degats") and can_take_damage:
			hp -= 1
			print("j_touché ! hp : ", hp)
			update_coeurs()
			$degatsound.stream = load("res://Jeu/Joueur/Assets_Joueur/degats.ogg")
			$degatsound.play()
			if hp <= 0:
				game_over()
			
			$playersprite.play()
			can_take_damage = false
			can_move = false
			$playersprite.animation = "damage"
			$playersprite.pause()
			await get_tree().create_timer(0.2, false).timeout
			can_move = true
			clignoter()
			await get_tree().create_timer(0.8, false).timeout
			can_take_damage = true
			$playersprite.play()
	if Input.is_action_pressed("Shooting") and can_shoot:
		var Projectile_Instance = projectile_scene.instantiate()
		Projectile_Instance.global_position = Shooting_Point.global_position
		owner.add_child(Projectile_Instance)
		can_shoot = false
		await get_tree().create_timer(0.1, false).timeout
		can_shoot = true

func update_coeurs():
	$CanvasLayer/Coeur1.texture = Coeur_Plein if hp >= 1 else Coeur_Vide
	$CanvasLayer/Coeur2.texture = Coeur_Plein if hp >= 2 else Coeur_Vide
	$CanvasLayer/Coeur3.texture = Coeur_Plein if hp >= 3 else Coeur_Vide

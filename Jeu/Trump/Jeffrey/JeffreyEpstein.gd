extends CharacterBody2D

var player: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Je_sprite
var speed := 2000.0

var screen_size: Vector2
var direction := Vector2.ZERO
var explosion_scene = preload("res://Jeu/Trump/Jeffrey/Jeyffrey_Explosion/explosion.tscn")
var hp=3
var is_waiting := false
var is_foncing := false

func _ready() -> void:
	global_scale=Vector2(1,1)
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	screen_size = get_viewport_rect().size
	print("player =", player)
	sprite.play()
	sprite.animation = "default"
	await get_tree().create_timer(0.4).timeout
	preparer_fonce()
 
func preparer_fonce() -> void:
	if player == null:
		return
	is_foncing = false
	is_waiting = true
	velocity = Vector2.ZERO
	sprite.animation = "default"
	
	direction = global_position.direction_to(player.global_position)
	is_foncing = true
	$Scream.play()
	is_waiting = false
func clignoter() -> void:
		for i in 4:
			sprite.modulate.a = 0.2
			await get_tree().create_timer(0.05).timeout
			sprite.modulate.a = 1.0
			await get_tree().create_timer(0.05).timeout
func _physics_process(delta: float) -> void:
	if player == null:
		return

	if is_foncing:
		velocity = direction * speed
		move_and_slide()

		if is_on_wall() or is_on_ceiling() or is_on_floor():
			$Scream.stop()
			if hp>1:
				$AudioStreamPlayer.play()
				clignoter()
				is_foncing = false
				is_waiting = true
				velocity = Vector2.ZERO
				sprite.animation = "damage"
				sprite.modulate = Color(1, 0.5, 0.5)
				print("je_touche le mur, attente 0.5s")
				await get_tree().create_timer(0.5).timeout
				sprite.modulate = Color(1, 1, 1)
				await get_tree().create_timer(0.5).timeout
				preparer_fonce()
				hp=hp-1
			else:
				var collision = get_slide_collision(0)
				var hit_pos = collision.get_position()
				print("explosion")
				is_foncing = false
				var explosion = explosion_scene.instantiate()
				get_parent().add_child(explosion)
				explosion.global_position=hit_pos
				$Je_sprite.hide()
				speed=0
				await get_tree().create_timer(0.4).timeout
				queue_free()
			

	global_position = global_position.clamp(Vector2.ZERO, screen_size)

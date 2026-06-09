extends CharacterBody2D

var player: CharacterBody2D
@onready var sprite: Sprite2D = $JDVsprite
var speed := 1000.0
var screen_size: Vector2
var direction := Vector2.ZERO
var explosion_scene = preload("res://Jeu/Trump/Jeffrey/Jeyffrey_Explosion/explosion.tscn")
var hp := 5
var dead := false

func _ready() -> void:
	global_scale = Vector2(0.33, 0.33)
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	screen_size = get_viewport_rect().size

	if player:
		direction = global_position.direction_to(player.global_position)

func clignoter() -> void:
	sprite.modulate.a = 0.2
	await get_tree().create_timer(0.05).timeout
	sprite.modulate.a = 1.0

func _physics_process(delta: float) -> void:
	if dead:
		return

	global_rotation += 0.2
	velocity = direction * speed

	var collision = move_and_collide(velocity * delta)
	if collision:
		print("jdv_hp ", hp)
		print("jdv_collision")

		if hp > 1:
			var n = collision.get_normal()
			$AudioStreamPlayer.play()
			direction = direction.bounce(n).normalized()
			hp -= 1
			clignoter()
			sprite.modulate = Color(1, 0.5, 0.5)
			print("jdv_touche le mur")
			await get_tree().create_timer(0.05).timeout
			sprite.modulate = Color(1, 1, 1)
		else:
			dead = true
			print("jdv_meurt")

			var hit_pos = collision.get_position()
			var explosion = explosion_scene.instantiate()
			get_parent().add_child(explosion)
			explosion.global_position = hit_pos

			sprite.hide()
			speed = 0
			await get_tree().create_timer(0.4).timeout
			queue_free()

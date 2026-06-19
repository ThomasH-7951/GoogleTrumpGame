extends Area2D

var speed = 2000
var direction = Vector2.DOWN

var explosion_scene = preload("res://Jeu/Trump/Jeffrey/Jeyffrey_Explosion/explosion.tscn")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	var randm = (randf()*40)-40
	var randm2 = (randf()*0.4)+0.8
	$AudioStreamPlayer.pitch_scale=randm2
	$AudioStreamPlayer.volume_db=randm
	$AudioStreamPlayer.play()
	global_scale = Vector2(0.4, 0.4)
	body_entered.connect(_on_missile_body_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_missile_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collision"):
		if global_position.y > get_viewport_rect().size.y * 0.3:
			$AudioStreamPlayer.stop()
			print("meurt")
			print("explosion")

			var explosion = explosion_scene.instantiate()
			get_parent().add_child(explosion)
			explosion.global_position = global_position

			$Missile.hide()
			monitoring = false
			
			await get_tree().create_timer(0.4, false).timeout
			print("je_free")
			queue_free()
	if body.is_in_group("Joueur"):
		$AudioStreamPlayer.stop()
		print("touchejoueurmissile")
		print("explosion")

		var explosion = explosion_scene.instantiate()
		get_parent().add_child(explosion)
		explosion.global_position = global_position

		$Missile.hide()
		monitoring = false
		
		await get_tree().create_timer(0.4, false).timeout
		print("je_free")
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

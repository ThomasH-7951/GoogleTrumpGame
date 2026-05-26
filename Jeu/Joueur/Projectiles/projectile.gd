extends Area2D
var speed = 2000
var direction = Vector2.RIGHT

func _ready():
	global_scale=Vector2(0.05,0.05)
	body_entered.connect(_on_balle_body_entered)
	area_entered.connect(_on_balle_area_entered)
	
	if direction == Vector2.RIGHT:
		rotation = 0
	elif direction == Vector2.LEFT:
		rotation = PI
	elif direction == Vector2.UP:
		rotation = -PI / 2
	elif direction == Vector2.DOWN:
		rotation = PI / 2

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	
func _on_balle_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collision"):
		queue_free()

func _on_balle_area_entered(area: Area2D) -> void:
	if area.name == "Zone_Colision_Trump":
		var bosses = get_tree().get_nodes_in_group("boss")
		if bosses.size() > 0:
			bosses[0].hp -= 1
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

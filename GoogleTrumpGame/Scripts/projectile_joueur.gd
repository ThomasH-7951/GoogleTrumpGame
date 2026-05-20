extends Area2D
var speed = 1000
var direction = Vector2.RIGHT

func _ready():
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
		print("mur touché : ", body.name)
		queue_free()

func _on_balle_area_entered(area: Area2D) -> void:
	if area.name == "Zone_Colision_Trump":
		var boss = get_tree().get_nodes_in_group("boss")[0]
		boss.hp -= 1
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

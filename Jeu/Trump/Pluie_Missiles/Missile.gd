extends Area2D

var speed = 2000
var direction = Vector2.DOWN

func _ready():
	global_scale = Vector2(0.5, 0.5)
	body_entered.connect(_on_missile_body_entered)
	area_entered.connect(_on_missile_area_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_missile_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collision"):
		queue_free()

func _on_missile_area_entered(area: Area2D) -> void:
	if area.name == "Zone_Colision_Joueur":
		print("joueur touché par un missile")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

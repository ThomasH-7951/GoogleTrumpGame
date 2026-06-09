extends Area2D
var missile = preload("res://Jeu/Trump/Pluie_Missiles/Missile.tscn")
var largeur = 250
var hauteur : float
var x_zone : float

func _ready() -> void:
	await get_tree().process_frame 
	var taille = get_viewport_rect().size
	hauteur = taille.y
	x_zone = global_position.x
	
	var rect = $ColorRect
	rect.size = Vector2(largeur, hauteur)
	rect.color = Color(1, 0, 0, 0.4)
	rect.position = Vector2.ZERO
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(largeur, hauteur)
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = Vector2(largeur / 2, hauteur / 2)
	
	await get_tree().create_timer(2.0).timeout
	spawner_missiles()

func spawner_missiles() -> void:
	var duree = 1
	var temps = 0.0
	
	while temps < duree:
		var m = missile.instantiate()
		get_tree().current_scene.add_child(m)
		var x = x_zone + randf_range(0, largeur)
		m.global_position = Vector2(x, -50)
		var cust_i = (randf()*0.04)+0.08
		await get_tree().create_timer(cust_i).timeout
		temps += cust_i
	
	queue_free()

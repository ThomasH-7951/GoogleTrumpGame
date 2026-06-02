extends Area2D

var missile = preload("res://Jeu/Trump/Pluie_Missiles/Missile.tscn")
var largeur = 200
var hauteur = 1080

func _ready() -> void:
	
	var x_aleatoire = randf_range(0, 1920 - largeur)
	global_position = Vector2(x_aleatoire, 0)
	
	var rect = $ColorRect
	rect.size = Vector2(largeur, hauteur)
	rect.color = Color(1, 0, 0, 0.4)
	rect.position = Vector2.ZERO
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(largeur, hauteur)
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = Vector2(largeur / 2, hauteur / 2)
	
	spawner_missiles()

func spawner_missiles() -> void:
	# Missiles pendant 3s puis la zone disparait
	var duree = 3.0
	var intervalle = 0.2  # un missile toutes les 0.2s
	var temps = 0.0
	
	while temps < duree:
		var m = missile.instantiate()
		get_tree().current_scene.add_child(m)
		# Position X aléatoire dans la zone rouge
		var x = global_position.x + randf_range(0, largeur)
		m.global_position = Vector2(x, -50)  # spawn au dessus de l'écran
		await get_tree().create_timer(intervalle).timeout
		temps += intervalle
	
	queue_free()

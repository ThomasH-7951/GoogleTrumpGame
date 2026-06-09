extends Node2D
var zone_rouge = preload("res://Jeu/Trump/Pluie_Missiles/Zone_Missiles.tscn")
var largeur_zone = 300

func spawner_zones() -> void:
	var nb_zones = randi_range(1, 3)
	var taille = get_viewport_rect().size
	var zones_x : Array = []  # garde les X déjà placés
	
	for i in nb_zones:
		var x = trouver_x_libre(zones_x, taille.x)
		if x == -1:
			break  # plus de place
		zones_x.append(x)
		var z = zone_rouge.instantiate()
		get_tree().current_scene.add_child(z)
		z.global_position = Vector2(x, 0)

func trouver_x_libre(zones_x: Array, largeur_map: float) -> float:
	var tentatives = 20
	for i in tentatives:
		var x = randf_range(0, largeur_map - largeur_zone)
		var libre = true
		for x_existant in zones_x:
			# Vérifie qu'il n'y a pas de chevauchement
			if abs(x - x_existant) < largeur_zone:
				libre = false
				break
		if libre:
			return x
	return -1  # pas trouvé

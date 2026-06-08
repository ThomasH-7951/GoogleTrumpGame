extends Node2D
enum Phase {PHASE0, PHASE1, PHASE2, PHASE3}
var phase_actuelle = Phase.PHASE0
signal transition_finie
var zone_rouge = preload("res://Jeu/Trump/Pluie_Missiles/Zone_Missiles.tscn")
const max_hp = 200
var hp = 200:
	set(value):
		hp = value
		$CanvasLayer/ProgressBar.value = hp
		if hp <= 0:
			print("boss mort !")
			game_win()
@export var speed := 600.0
var jeff = preload("res://Jeu/Trump/Jeffrey/JeffreyEpstein.tscn")
var jeff_encours: Node2D = null
const CENTRE := Vector2(570, 90)
var path_follows : Array[PathFollow2D] = []
var path_index := 0
var en_transition := false

@onready var win_screen = $"../WinScreen"
func game_win():
	get_tree().paused = true
	win_screen.show()

func _ready() -> void:
	add_to_group("boss")
	$CanvasLayer/ProgressBar.max_value = max_hp
	$CanvasLayer/ProgressBar.value = hp
	path_follows = [
		$PathCarre/TrumpPathFollow,
		$PathRandom/TrumpPathFollow,
		$PathCarre/TrumpPathFollow,
		$PathRandom/TrumpPathFollow,
	]
	await get_tree().process_frame
	lancer_phase()

func path_actif() -> PathFollow2D:
	return path_follows[path_index % path_follows.size()]

func _process(delta: float):
	if en_transition:
		return
	path_actif().progress += speed * delta
	$PathCarre/TrumpPathFollow.global_position = path_actif().global_position
	$PathCarre/TrumpPathFollow/Trumpsprite.play()

func revenir_au_centre(prochain_index: int) -> void:
	en_transition = true
	while true:
		var direction = CENTRE - $PathCarre/TrumpPathFollow.global_position
		if direction.length() < 5.0:
			$PathCarre/TrumpPathFollow.global_position = CENTRE
			break
		$PathCarre/TrumpPathFollow.global_position += direction.normalized() * speed * get_process_delta_time()
		$PathCarre/TrumpPathFollow/Trumpsprite.play()
		await get_tree().process_frame
	await get_tree().create_timer(2.0).timeout 
	path_index = prochain_index
	path_follows[path_index].progress = 0.0
	en_transition = false

func lancer_phase():
	match phase_actuelle:
		Phase.PHASE0:
			spawner_zone_rouge()
			await get_tree().create_timer(5.0).timeout
			await revenir_au_centre(1)
			phase_actuelle = Phase.PHASE1

		Phase.PHASE1:
			spawner_zone_rouge()
			await get_tree().create_timer(5.0).timeout
			await revenir_au_centre(2)
			phase_actuelle = Phase.PHASE2

		Phase.PHASE2:
			spawner_zone_rouge()
			await attaque_Jeffrey()
			await revenir_au_centre(3)
			phase_actuelle = Phase.PHASE3

		Phase.PHASE3:
			spawner_zone_rouge()
			await get_tree().create_timer(5.0).timeout
			await revenir_au_centre(0)
			phase_actuelle = Phase.PHASE0
	lancer_phase()

func attaque_Jeffrey():
	if jeff_encours == null or not is_instance_valid(jeff_encours):
		jeff_encours = jeff.instantiate()
		add_child(jeff_encours)
		jeff_encours.global_position = $PathCarre/TrumpPathFollow.global_position
	await get_tree().create_timer(5.0).timeout

func spawner_zone_rouge() -> void:
	var z = zone_rouge.instantiate()
	get_tree().current_scene.add_child(z)
	# Disparait après 3s
	await get_tree().create_timer(3.0).timeout
	z.queue_free()

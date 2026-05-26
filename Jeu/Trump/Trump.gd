extends Node2D
# == PV ==
const max_hp = 200
var hp = 200:
	set(value):
		hp = value
		$CanvasLayer/ProgressBar.value = hp
		if hp <= 0:
			print("boss mort !")

# == Déplacement ==
@export var speed := 600.0
var jeff = preload("res://Jeu/Trump/Jeffrey/JeffreyEpstein.tscn")
var jeff_encours: Node2D = null

func _ready() -> void:
	add_to_group("boss")
	$CanvasLayer/ProgressBar.max_value = max_hp
	$CanvasLayer/ProgressBar.value = hp

func _process(delta: float):
	$TrumpPath/TrumpPathFollow.progress += speed * delta
	$TrumpPath/TrumpPathFollow/Trumpsprite.play()
	
	var randomtick = (randi() % 100)
	if randomtick == 1:
		if jeff_encours == null or not is_instance_valid(jeff_encours):
			jeff_encours = jeff.instantiate()
			add_child(jeff_encours)
			jeff_encours.global_position = $TrumpPath/TrumpPathFollow.global_position

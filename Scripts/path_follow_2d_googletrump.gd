extends PathFollow2D

@export var speed := 600.0
var jeff = preload("res://Scenes/je.tscn")
var jeff_encours: Node2D = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	progress += speed * delta
	$Trumpsprite.play()
	var randomtick = (randi() % 100)
	print(randomtick)
	if randomtick==1:
		if jeff_encours == null or not is_instance_valid(jeff_encours):
			print("invoque jeff")
			jeff_encours = jeff.instantiate()
			get_parent().add_child(jeff_encours)
			jeff_encours.global_position = global_position
		

		

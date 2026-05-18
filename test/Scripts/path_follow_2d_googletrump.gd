extends PathFollow2D

@export var speed := 500.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += speed * delta
	$AnimatedSprite2D.play()

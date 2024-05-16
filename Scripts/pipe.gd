extends Area2D
signal gameover
signal point

@onready var point_area = %PointArea

func _process(delta):
	global_position.x -= 200 * delta
	if global_position.x < 0:
		queue_free()


func _on_body_entered(body):
	if body.name == 'Flappy':
		gameover.emit()


func _on_point_area_body_entered(body):
	if body.name == 'Flappy':
		point.emit()

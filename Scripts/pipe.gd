extends Area2D
signal gameover
signal point

@onready var point_area = %PointArea
const PIPE_SPEED = 200

func _process(delta):
	global_position.x -= PIPE_SPEED * delta
	if global_position.x < 0:
		queue_free()


func _on_body_entered(body):
	if body.name == 'Flappy':
		gameover.emit()


func _on_point_area_body_entered(body):
	if body.name == 'Flappy':
		point.emit()

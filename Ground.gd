extends Area2D
signal gameover



func _on_body_entered(body):
	if body.name == 'Flappy':
		gameover.emit()

extends Area2D
signal game_over

func _on_body_entered(body):
	if body.name == "Flappy":
		call_deferred("end_game")
		
func end_game():
	game_over.emit()

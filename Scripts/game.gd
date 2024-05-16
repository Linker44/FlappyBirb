extends Node2D

const X_OFFSET = 300
const Y_OFFSET = 350

@onready var pipe_spawn_timer = %PipeSpawnTimer
@onready var ground = %Ground
@onready var point_ui = %PointUI

func _ready():
	ground.gameover.connect(restart)
	pipe_spawn_timer.start()
	spawn_pipe()

func _process(delta):
	ground.global_position.x -= 200 * delta
	if ground.global_position.x < 0:
		ground.global_position.x = get_viewport_rect().size.x

func spawn_pipe():
	var pipe = preload("res://Scenes/pipe.tscn").instantiate()
	pipe.gameover.connect(restart)
	pipe.point.connect(new_point)
	var viewport_size = get_viewport_rect().size
	pipe.global_position = Vector2(viewport_size.x + X_OFFSET, randf_range(Y_OFFSET, viewport_size.y - Y_OFFSET))
	add_child(pipe)

func restart():
	call_deferred('restart_deffered')
	
func new_point():
	point_ui.add_point()

func restart_deffered():
	get_tree().reload_current_scene()

func _on_timer_timeout():
	spawn_pipe()

func _on_difficulty_timer_timeout():
	if pipe_spawn_timer.wait_time > 1.5:
		pipe_spawn_timer.wait_time -= 0.2

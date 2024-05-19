extends Node2D

const OFFSET = 300
const GROUND_SPEED = 200

@onready var pipe_spawn_timer = %PipeSpawnTimer
@onready var ground = %Ground
@onready var point_ui = %PointUI
@export var pipe_scene: PackedScene

func _ready():
	ground.gameover.connect(restart)
	pipe_spawn_timer.start()
	spawn_pipe()

func _process(delta):
	ground.global_position.x -= GROUND_SPEED * delta
	if ground.global_position.x < 0:
		ground.global_position.x = get_viewport_rect().size.x

func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	pipe.gameover.connect(restart)
	pipe.point.connect(new_point)
	var viewport_size = get_viewport_rect().size
	pipe.global_position = Vector2(viewport_size.x + OFFSET, randf_range(OFFSET, viewport_size.y - OFFSET))
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

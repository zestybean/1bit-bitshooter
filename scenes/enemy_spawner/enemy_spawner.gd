extends Node2D

@export var enemy_scene:PackedScene
@export var boss_scene:PackedScene
@onready var spawn_rate_timer:Timer = $SpawnRateTimer
@onready var spawn_points:Node2D = $SpawnPoints

func get_spawn_position()->int:
	var points:Array = spawn_points.get_children()
	randomize()
	var random_y := randi_range(points[0].position.y, points[1].position.y)
	return random_y
	
func spawn_enemy()->void:
	var enemy := enemy_scene.instantiate()
	var world := get_tree().current_scene
	world.add_child(enemy)
	var spawn_position := get_spawn_position()
	enemy.global_position = Vector2(position.x, spawn_position)
	
func spawn_boss()->void:
	var boss := boss_scene.instantiate()
	var world := get_tree().current_scene
	world.add_child(boss)
	boss.connect("boss_destroyed", await world._on_boss_destroyed)
	boss.global_position = Vector2(400, 90)

func _on_timer_timeout()->void:
	spawn_enemy() # Replace with function body.

func _on_enemy_limit_and_boss_spawn_timer_timeout()->void:
	spawn_rate_timer.stop()
	spawn_boss() # Replace with function body.

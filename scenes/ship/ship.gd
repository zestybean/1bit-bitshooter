extends Area2D

@export var laser_scene: PackedScene

@export var speed:float = 100
@export var margin: = 8

var height:Variant= ProjectSettings.get_setting("display/window/size/viewport_height")

@onready var left_wing_thrust := $LeftWingThrust
@onready var right_wing_thrust := $RightWingThrust

signal ship_destroyed

func _process(delta: float)->void:
	if Input.is_action_pressed("move_up"):
		
		position.y -= speed * delta
		
	if Input.is_action_pressed("move_down"):
		right_wing_thrust.emitting = true
		position.y += speed * delta
		
	var direction:float = Input.get_axis("move_up", "move_down")

	global_position.y = clamp(self.global_position.y, 0 + margin, height - margin)
	
	if direction == 1:
		skew = 0.1
		left_wing_thrust.emitting = true
	elif direction == -1:
		skew = -0.1
		right_wing_thrust.emitting = true
	else:
		skew = 0
		left_wing_thrust.emitting = false
		right_wing_thrust.emitting = false
		
	if Input.is_action_just_pressed("ui_accept"):
		var world := get_tree().current_scene
		var laser := laser_scene.instantiate()

		world.add_child(laser)
		laser.position = position
		
	
func _on_area_entered(area: Area2D)->void:
	queue_free()
	area.queue_free()
	ship_destroyed.emit()

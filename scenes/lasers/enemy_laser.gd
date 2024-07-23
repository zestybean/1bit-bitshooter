extends Area2D

# Speed of rotation in degrees per second
var rotation_speed_degrees: float = 250.0  # 90 degrees per second
var speed: float = 150

func _process(delta: float) -> void:
	# Increment the rotation by the rotation speed multiplied by delta
	rotation_degrees += rotation_speed_degrees * delta
	position.x -= speed * delta

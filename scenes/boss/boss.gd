extends Area2D

@export var speed:float = 20
@export var armor:int = 3

func _process(delta:float)->void:
	
	if position.x < 280:
		speed = 0.0
	
	position.x -= speed * delta

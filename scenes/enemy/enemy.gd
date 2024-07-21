extends Area2D

@export var speed:float = 100
@export var armor:int = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float)->void:
	position.x -= speed * delta


func _on_body_entered(body: Node2D)->void:
	body.queue_free()
	armor -= 1
	
	if(armor <= 0):
		var world := get_tree().current_scene
		world.score += 10
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited()->void:
	queue_free()

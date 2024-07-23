extends Node2D

@export var effect_scene:PackedScene
@export var effect_scale:float = 1

var height:Variant= ProjectSettings.get_setting("display/window/size/viewport_height")
var width:Variant= ProjectSettings.get_setting("display/window/size/viewport_width")

func _exit_tree()->void:
	if not effect_scene is PackedScene:
		return
	
	if global_position.x < 0 or global_position.x > width:
		return	
	
	if global_position.y < 0 or global_position.y > height:
		return
		
	var world := get_tree().current_scene
	var effect := effect_scene.instantiate()
	effect.scale *= effect_scale
	world.add_child.call_deferred(effect)
	effect.global_position = global_position

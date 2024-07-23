extends Node2D
@onready var score_label:Label = $Label

var score:int = 0 :
	get:
		return score
	set(value):
		score = value
		score_label.text = "Score: " + str(score)
		
func _process(_delta:float)->void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_ship_ship_destroyed()->void:
	await get_tree().create_timer(1.5).timeout
	var highscore := SaveAndLoad.load_highscore()
	if highscore != null:
		if score > highscore:
			SaveAndLoad.save_highscore(score)
	else:
		SaveAndLoad.save_highscore(score)
	get_tree().change_scene_to_file("res://scenes/levels/game_over_screen.tscn")
	
func _on_boss_destroyed()->void:
	await get_tree().create_timer(3.0).timeout
	var highscore := SaveAndLoad.load_highscore()
	if highscore != null:
		if score > highscore:
			SaveAndLoad.save_highscore(score)
	else:
		SaveAndLoad.save_highscore(score)
	get_tree().change_scene_to_file("res://scenes/levels/game_over_screen.tscn")

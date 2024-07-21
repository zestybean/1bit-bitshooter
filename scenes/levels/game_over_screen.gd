extends ColorRect
@onready var high_score_label:Label= $CenterContainer/VBoxContainer/HighScoreLabel

func _ready()->void:
	var highscore := SaveAndLoad.load_highscore()
	if highscore == -1: return
	high_score_label.text = "Highscore: " + str(highscore)

func _process(_delta:float)->void:
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene_to_file("res://scenes/levels/start_menu.tscn")
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


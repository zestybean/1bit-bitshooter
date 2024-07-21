extends Node

const SAVE_PATH := "user://save.cfg"

func save_highscore(highscore:int)->void:
	var config := ConfigFile.new()
	config.set_value("game", "highscore", highscore)
	config.save(SAVE_PATH)
	
func load_highscore()->int:
	var highscore := 0
	var config := ConfigFile.new()
	var error := config.load(SAVE_PATH)
	if error != OK: return -1
	highscore = config.get_value("game", "highscore")
	return highscore

extends Node

var config_path := "user://settings.cfg"


func _ready():
	if not FileAccess.file_exists(config_path):
		pass
		

func load() -> ConfigFile:
	var config := ConfigFile.new()
	if FileAccess.file_exists(config_path):
		config.load(config_path)
	
	return config

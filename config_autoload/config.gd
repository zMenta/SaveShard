extends Node

var config_path := "user://settings.cfg"


func _ready():
	# Default save values if config don't exist
	if not FileAccess.file_exists(config_path):
		create_config_default()


func create_config_default() -> void:
	var config := ConfigFile.new()
	config.set_value("settings", "stoneshard_directory", null)
	config.set_value("settings", "save_directory", "user://")
	config.save(config_path)


func config_load() -> ConfigFile:
	var config := ConfigFile.new()
	if FileAccess.file_exists(config_path):
		config.load(config_path)
	
	return config


func set_value(section: String, key: String , value: Variant) -> void:
	var config := ConfigFile.new()
	if not FileAccess.file_exists(config_path):
		return
		
	var err = config.load(config_path)
	if err != OK:
		return
		
	config.set_value(section, key, value)

extends Node

var config_path := "user://settings.cfg"
var data := ConfigFile.new()


func _ready():
	if not FileAccess.file_exists(config_path): create_config_default()
	data.load(config_path)


func create_config_default() -> void:
	data.set_value("settings", "stoneshard_directory", "")
	data.set_value("settings", "save_directory", "user://")
	data.save(config_path)

func set_value(section: String, key: String , value: Variant) -> void:		
	data.set_value(section, key, value)
	
func get_value(section: String, key: String, default_value: Variant = null) -> Variant:
	return data.get_value(section, key, default_value)
	
func load_data() -> Error:
	return data.load(config_path)

func save() -> Error:
	return data.save(config_path)

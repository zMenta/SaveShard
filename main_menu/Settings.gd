extends MarginContainer

@onready var dir_name_label := $VBoxContainer/StoneDirectory/HBoxContainer2/DirNameLabel
@onready var file_dialog := $FileDialog
@onready var warning_label := $VBoxContainer/StoneDirectory/WarningLabel

var config := ConfigFile.new()
var config_path := "user://settings.cfg"
var default_save_path := ProjectSettings.globalize_path("user://")


func _ready():
	_load_config()


func _load_config() -> void:
	if FileAccess.file_exists(config_path):
		config.load(config_path)
		dir_name_label.text = config.get_value("settings", "stoneshard_directory")
		dir_name_label.show()
		warning_label.hide()
	else:
		dir_name_label.hide()
		warning_label.show()
	

func _on_dir_button_pressed():
	file_dialog.show()


func _on_file_dialog_dir_selected(dir):
	dir_name_label.text = dir
	config.set_value("settings", "stoneshard_directory", dir)
	config.save(config_path)
	
	dir_name_label.show()
	warning_label.hide()


func _on_clear_data_pressed():
	if FileAccess.file_exists(config_path):
		DirAccess.remove_absolute(config_path)
		_load_config()

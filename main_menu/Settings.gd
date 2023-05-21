extends MarginContainer

@onready var dir_name_label := $VBoxContainer/StoneDirectory/HBoxContainer2/DirNameLabel
@onready var save_dir_name := $VBoxContainer/BackupDirectory/HBoxContainer2/SaveDirNameLabel
@onready var stone_file_dialog := $StoneDirectory
@onready var save_file_dialog := $SaveDirectory
@onready var warning_label := $VBoxContainer/StoneDirectory/WarningLabel

var config := ConfigFile.new()

func _ready():
	_load_config()

func _load_config() -> void:
	# Defaults 
	dir_name_label.hide()
	warning_label.show()
	save_dir_name.text = ProjectSettings.globalize_path("user://")
	$VBoxContainer/SaveDirNameLabel2.text = ProjectSettings.globalize_path("user://")
	
	config = Config.config_load()
	var stoneshard_directory = config.get_value("settings", "stoneshard_directory", null)
	var save_directory = config.get_value("settings", "save_directory", null)
	if stoneshard_directory != null:
		dir_name_label.text = stoneshard_directory
		stone_file_dialog.current_dir = stoneshard_directory
		dir_name_label.show()
		warning_label.hide()			
		
	if save_directory != null:
		save_dir_name.text = save_directory
		save_file_dialog.current_dir = save_directory



func _on_dir_button_pressed():
	stone_file_dialog.show()


func _on_save_dir_button_pressed():
	save_file_dialog.show()
	
	
func _on_file_dialog_dir_selected(dir):
	dir_name_label.text = dir
	config.set_value("settings", "stoneshard_directory", dir)
	config.save(config_path)
	
	dir_name_label.show()
	warning_label.hide()


func _on_save_directory_dir_selected(dir):
	save_dir_name.text = dir
	config.set_value("settings", "save_directory", dir)
	config.save(config_path)


func _on_clear_data_pressed():
	if FileAccess.file_exists(config_path):
		DirAccess.remove_absolute(config_path)
		_load_config()






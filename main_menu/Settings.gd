extends MarginContainer

@onready var dir_name_label := $VBoxContainer/StoneDirectory/HBoxContainer2/DirNameLabel
@onready var save_dir_name := $VBoxContainer/BackupDirectory/SaveDirName
@onready var stone_file_dialog := $StoneDirectory
@onready var save_file_dialog := $SaveDirectory
@onready var warning_label := $VBoxContainer/StoneDirectory/WarningLabel


func _ready():
	_load_config()


func _load_config() -> void:
	# Defaults 
	dir_name_label.hide()
	warning_label.show()
	save_dir_name.text = ProjectSettings.globalize_path("user://")
	save_dir_name.text = ProjectSettings.globalize_path("user://")
	save_file_dialog.current_dir = ProjectSettings.globalize_path("user://")
	
	if Config.load_data() != OK:
		return
		
	var stoneshard_directory = Config.get_value("settings", "stoneshard_directory")
	var save_directory = Config.get_value("settings", "save_directory")
	if stoneshard_directory != "":
		dir_name_label.text = stoneshard_directory
		stone_file_dialog.current_dir = stoneshard_directory
		dir_name_label.show()
		warning_label.hide()			
		
	if save_directory != "user://":
		save_dir_name.text = save_directory
		save_file_dialog.current_dir = save_directory
	


func _on_dir_button_pressed():
	stone_file_dialog.show()


func _on_save_dir_button_pressed():
	save_file_dialog.show()
	
	
func _on_file_dialog_dir_selected(dir):
	dir_name_label.text = dir
	Config.set_value("settings", "stoneshard_directory", dir)
	Config.save()
	
	dir_name_label.show()
	warning_label.hide()


func _on_save_directory_dir_selected(dir):
	save_dir_name.text = dir
	Config.set_value("settings", "save_directory", dir)
	Config.save()


func _on_clear_data_pressed():
	Config.create_config_default()
	_load_config()






extends VBoxContainer

var config_path := "user://settings.cfg"
var save_folder_name := "/saveshard_saves"
var save_path : String

func _ready():
	save_path = Config.get_value("settings", "save_directory", "user://") + save_folder_name
	
func _on_save_button_pressed():
	if not DirAccess.dir_exists_absolute(save_path):
		DirAccess.make_dir_absolute(save_path)
	
#	DirAccess.copy_absolute()



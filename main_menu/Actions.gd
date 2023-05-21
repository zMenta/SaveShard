extends VBoxContainer

var config := ConfigFile.new()
var config_path := "user://settings.cfg"
var backup_path : String = "user://saves"
var stoneshard_save_path : String

func _ready():
	if not DirAccess.dir_exists_absolute("user://saves"):
		DirAccess.make_dir_absolute("user://saves")

	if FileAccess.file_exists(config_path):
		config.load(config_path)


func _on_save_button_pressed():
	pass
#	DirAccess.copy_absolute()



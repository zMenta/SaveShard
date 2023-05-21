extends VBoxContainer

var config := ConfigFile.new()
var config_path := "user://settings.cfg"
var save_path : String = "user://"


func _on_save_button_pressed():
#	DirAccess.copy_absolute()
	print(save_path)




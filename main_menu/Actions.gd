extends VBoxContainer

@onready var widget := $"../SaveWidget"
@onready var option_button := $"../CharacterSelection/OptionButton"
@onready var log_label := $LogLabel

var config_path := "user://settings.cfg"
var save_folder_name := "saveshard_saves"
var save_path : String
var current_character := "character_1"

func _ready():
	save_path = Config.get_value("settings", "save_directory", "user://") + save_folder_name
	await widget.ready
	widget.button_save.pressed.connect(_on_save_button_pressed)
	widget.button_insert.pressed.connect(_on_insert_button_pressed)
	
	
func _on_save_button_pressed():
	if not DirAccess.dir_exists_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name):
		DirAccess.make_dir_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name)
	
	var stoneshard_path = Config.get_value("settings", "stoneshard_directory")
	var exitsave_path : String = stoneshard_path + "/characters_v1/" + current_character + "/exitsave_1"
	
	if not DirAccess.dir_exists_absolute(exitsave_path):
		log_label.text = "Error: Exitsave don't exist."
		widget.animation.play("error_message")		
		return
		
	var character_save_path: String = save_path + "/" + current_character
	if not DirAccess.dir_exists_absolute(character_save_path):
		DirAccess.make_dir_absolute(character_save_path)
	
	
	if _copy_dir_files(exitsave_path, character_save_path) != OK:
		log_label.text = "An error occured when copying save files"
		widget.animation.play("error_message")		
		return

	log_label.text = "Exitsave copied with sucess"
	widget.animation.play("ok_message")


func _on_insert_button_pressed():
	var backup_path : String = Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name + "/" + current_character
	if not DirAccess.dir_exists_absolute(backup_path):
		log_label.text = "Error: No save directory found with this character"
		widget.animation.play("error_message")		
		return
	
	var files = DirAccess.get_files_at(backup_path)
	if len(files) < 3:
		log_label.text = "Error reading backup save files"
		widget.animation.play("error_message")
		return
	
	var char_save_path : String = Config.get_value("settings", "stoneshard_directory") + "/characters_v1/" + current_character + "/exitsave_1" 
	if not DirAccess.dir_exists_absolute(char_save_path):
		DirAccess.make_dir_absolute(char_save_path)
		
	if _copy_dir_files(backup_path, char_save_path) != OK: return
	log_label.text = "Exitsave Inserted with sucess"
	widget.animation.play("ok_message")


func _copy_dir_files(from: String, to: String) -> Error:
	for file in DirAccess.get_files_at(from):
		var err = DirAccess.copy_absolute(from + "/" + file, to + "/" + file)
		if err != OK: return err
	return OK


func _on_option_button_item_selected(index):
	current_character = option_button.get_item_text(index)




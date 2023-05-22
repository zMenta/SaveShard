extends VBoxContainer

@onready var option_button := $"../CharacterSelection/OptionButton"
@onready var log_label := $LogLabel

var config_path := "user://settings.cfg"
var save_folder_name := "saveshard_saves"
var save_path : String
var current_character := "character_1"

func _ready():
	save_path = Config.get_value("settings", "save_directory", "user://") + save_folder_name
	
func _on_save_button_pressed():
	if not DirAccess.dir_exists_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name):
		DirAccess.make_dir_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name)
	
	var stoneshard_path = Config.get_value("settings", "stoneshard_directory")
	var exitsave_path : String = stoneshard_path + "/characters_v1/" + current_character + "/exitsave_1"
	
	if not DirAccess.dir_exists_absolute(exitsave_path):
		log_label.text = "Error: Exitsave don't exist."
		return
		
	var character_save_path: String = save_path + "/" + current_character
	if not DirAccess.dir_exists_absolute(character_save_path):
		DirAccess.make_dir_absolute(character_save_path)
	
	for file in DirAccess.get_files_at(exitsave_path):
		var err = DirAccess.copy_absolute(exitsave_path + "/" + file, character_save_path + "/" + file)
		if err != OK:
			log_label.text = "An error occured when copying save files"
			return

	log_label.text = "Exitsave copied with sucess"

func _on_option_button_item_selected(index):
	current_character = option_button.get_item_text(index)

extends VBoxContainer

@onready var widget := $"../SaveWidget"
@onready var option_button := $"../CharacterSelection/OptionButton"
@onready var log_label := $LogLabel
@onready var animation := $AnimationPlayer
@onready var automatic_timer: Timer = %AutomaticOperationTimer

var config_path := "user://settings.cfg"
var save_folder_name := "saveshard_saves"
var save_path : String
var current_character := "character_1"
var is_backup_automated: bool = false
var is_insert_automated: bool = false
var timer_swap: bool = true

func _ready():
	save_path = Config.get_value("settings", "save_directory", "user://") + save_folder_name
	await widget.ready
	widget.button_save.pressed.connect(_on_save_button_pressed)
	widget.button_insert.pressed.connect(_on_insert_button_pressed)
	Config.config_changed.connect(_load_config)
	_load_config()

func _load_config() -> void:
	if Config.load_data() != OK:
		push_error("Error: Was not able to load confg data")
		return

	is_backup_automated = Config.get_value("settings", "automatic_backup", false)
	is_insert_automated = Config.get_value("settings", "automatic_insert", false)

func _on_save_button_pressed():
	if not DirAccess.dir_exists_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name):
		DirAccess.make_dir_absolute(Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name)
	
	var stoneshard_path = Config.get_value("settings", "stoneshard_directory")
	var exitsave_path: String = stoneshard_path + "/characters_v1/" + current_character + "/exitsave_1"
	var exitsave_files: PackedStringArray = DirAccess.get_files_at(exitsave_path)
	
	if not DirAccess.dir_exists_absolute(exitsave_path):
		log_label.text = "Error: Exitsave directory %s don't exist." % exitsave_path
		widget.animation.play("error_message")		
		animation.play("error_log")
		return
		
	var character_save_path: String = save_path + "/" + current_character
	if not DirAccess.dir_exists_absolute(character_save_path):
		DirAccess.make_dir_absolute(character_save_path)
	
	if exitsave_files.size() == 0:
		log_label.text = "No exitsave found for '%s'" % current_character
		widget.animation.play("warning_message")		
		animation.play("warning_log")
		return
	
	if _copy_dir_files(exitsave_path, character_save_path) != OK:
		log_label.text = "An error occured when copying save files"
		widget.animation.play("error_message")	
		animation.play("error_log")			
		return

	log_label.text = "%s: Exitsave copied with sucess" % current_character
	widget.animation.play("ok_message")
	animation.play("sucess_log")


func _on_insert_button_pressed():
	var backup_path : String = Config.get_value("settings", "save_directory", "user://") + "/" + save_folder_name + "/" + current_character
	if not DirAccess.dir_exists_absolute(backup_path):
		log_label.text = "Error: No save directory %s found with this character" % backup_path
		widget.animation.play("error_message")
		animation.play("error_log")
		return
	
	var files = DirAccess.get_files_at(backup_path)
	if len(files) < 3:
		log_label.text = "Error reading backup save files at %s" % backup_path
		widget.animation.play("error_message")
		animation.play("error_log")
		return
	
	var char_save_path : String = Config.get_value("settings", "stoneshard_directory") + "/characters_v1/" + current_character + "/exitsave_1" 
	if not DirAccess.dir_exists_absolute(char_save_path):
		DirAccess.make_dir_absolute(char_save_path)
		
	if _copy_dir_files(backup_path, char_save_path) != OK: return
	log_label.text = "%s: Exitsave Inserted with sucess" % current_character
	widget.animation.play("ok_message")
	animation.play("sucess_log")


func _copy_dir_files(from: String, to: String) -> Error:
	for file in DirAccess.get_files_at(from):
		var err = DirAccess.copy_absolute(from + "/" + file, to + "/" + file)
		if err != OK: return err
	return OK


func _on_option_button_item_selected(index):
	current_character = option_button.get_item_text(index)
	Config.set_value("system", "last_used_character", current_character)
	Config.save()


func _on_refresh_button_pressed() -> void:
	log_label.text = "Files refreshed"
	widget.animation.play("ok_message")
	animation.play("sucess_log")


func _on_automatic_operation_timer_timeout() -> void:
	if timer_swap:
		if is_backup_automated:
			_on_save_button_pressed()
	else:
		if is_insert_automated:
			_on_insert_button_pressed()

	timer_swap = not timer_swap

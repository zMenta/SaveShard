extends MarginContainer

@onready var character_option_button := $VBoxContainer/CharacterSelection/OptionButton
@onready var error_label := $ErrorLabel
@onready var log_error_label: Label = %LogErrorLabel

const SUFFIX := "/characters_v1"
var errors: Array[String] = []

func _ready():
	_load_config()

func _load_config() -> void:
	errors = []
	log_error_label.text = ""
	error_label.show()
	$VBoxContainer.hide()
	character_option_button.clear()

	if Config.load_data() != OK: return
	var stone_path = Config.get_value("settings", "stoneshard_directory")
	var dirs = DirAccess.get_directories_at(stone_path + SUFFIX)
	
	if len(dirs) != 0:
		$VBoxContainer.show()
		error_label.hide()
	
	character_option_button.clear()
	## Verify other possible paths, for exitsave and normal save.

	for dir in dirs:
		var exitsave_image_path: String = stone_path + SUFFIX + "/" + dir + "/exitsave_1/preview.png"
		var autosave_image_path: String = stone_path + SUFFIX + "/" + dir + "/autosave_1/preview.png"

		if not FileAccess.file_exists(exitsave_image_path) or not FileAccess.file_exists(autosave_image_path):
			_log_message("File '%s' or '%s' does not exist, skipping %s" % [exitsave_image_path, autosave_image_path, dir])
			continue

		var img = Image.load_from_file(exitsave_image_path)
		if img == null:
			img = Image.load_from_file(autosave_image_path)
			if img == null:
				_log_message("Couldn't load save images files, skipping %s" % dir)
				continue
		
		var tex = ImageTexture.create_from_image(img)
		tex.set_size_override(tex.get_size() * 0.6)
		character_option_button.add_icon_item(tex, dir)
	
	character_option_button.item_selected.emit(0)

	# Not adding the error label logs yet, just hiding it for now.
	#
	# var i: int = 0
	# for err in errors:
	# 	log_error_label.text += "Log %s: '%s', \n" % [i, err]
	# 	i += 1

func _on_tab_container_tab_changed(_tab):
	_load_config()

func _log_message(message: String) -> void:
	push_warning(message)
	errors.append(message)

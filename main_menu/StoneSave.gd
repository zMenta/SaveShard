extends MarginContainer

@onready var character_option_button := $VBoxContainer/CharacterSelection/OptionButton
@onready var error_label := $ErrorLabel

var prefix := "/characters_v1"
var config_path := "user://settings.cfg"
var config := ConfigFile.new()

func _ready():
	_load_config()

func _load_config() -> void:
	error_label.show()
	$VBoxContainer.hide()
	var status = config.load(config_path)
	character_option_button.clear()

	if status != OK:
		return

	var stone_path = config.get_value("settings", "stoneshard_directory")
	var dirs = DirAccess.get_directories_at(stone_path + prefix)
	
	if len(dirs) != 0:
		$VBoxContainer.show()
		error_label.hide()
	
	character_option_button.clear()
	## Verify other possible paths, for exitsave and normal save.
	for dir in dirs:
		var img = Image.load_from_file(stone_path + prefix + "/" + dir + "/exitsave_1/preview.png")
		if img == null:
			return
		
		var tex = ImageTexture.create_from_image(img)
		tex.set_size_override(tex.get_size() * 0.6)
		character_option_button.add_icon_item(tex, dir)


func _on_tab_container_tab_changed(_tab):
	_load_config()

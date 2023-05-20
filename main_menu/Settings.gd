extends MarginContainer

@onready var dir_name_label := $VBoxContainer/HBoxContainer2/DirNameLabel
@onready var file_dialog := $FileDialog

func _on_dir_button_pressed():
	file_dialog.show()


func _on_file_dialog_dir_selected(dir):
	dir_name_label.text = dir
	print(dir_name_label.label_settings)

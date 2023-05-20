extends MarginContainer

@onready var dir_name_label := $VBoxContainer/StoneDirectory/DirNameLabel
@onready var file_dialog := $FileDialog

func _on_dir_button_pressed():
	file_dialog.show()


func _on_file_dialog_dir_selected(dir):
	dir_name_label.text = dir
	dir_name_label.show()
	$VBoxContainer/StoneDirectory/ToolTipLabel.hide()

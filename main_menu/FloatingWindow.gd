extends VBoxContainer

@onready var window := $SaveWidget
@onready var window_container := $WindowContainer
@onready var window_button := $WindowButton


func _ready():
	if window.visible == false:
		window_container.hide()
	else:
		window_container.show()


func _on_window_button_pressed():
	if window.visible == false:
		window_button.text = "Close Window Widget"
		window.show()
	else:
		window_button.text = "Open Window Widget"
		window.hide()



func _on_save_widget_visibility_changed():
	if window.visible == false:
		window_container.hide()
	else:
		window_container.show()


func _on_save_widget_close_requested():
	window.hide()


func _on_bordless_check_toggled(button_pressed):
	window.borderless = button_pressed

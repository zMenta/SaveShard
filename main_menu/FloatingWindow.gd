extends VBoxContainer

@export var icon_open : Texture2D
@export var icon_close : Texture2D

@onready var window := $"../SaveWidget"
@onready var window_container := $WindowContainer
@onready var window_button := $WindowButton
@onready var window_scale_label := $WindowContainer/HBoxContainer/VBoxContainer2/WidgetScaleLabel

var screen_size: Vector2i
var screen_zero_position: Vector2i

func _ready():
	if window.visible == false:
		window_container.hide()
	else:
		window_container.show()

	var primary_screen_id = DisplayServer.get_primary_screen()
	screen_size = DisplayServer.screen_get_usable_rect(primary_screen_id).size
	screen_zero_position = DisplayServer.screen_get_usable_rect(primary_screen_id).position


func _on_window_button_pressed():
	if window.visible == false:
		window_button.text = "Close Window Widget"
		window_button.icon = icon_close
		window.show()
	else:
		window_button.text = "Open Window Widget"
		window_button.icon = icon_open		
		window.hide()


func _on_save_widget_visibility_changed():
	if window.visible == false:
		window_container.hide()
	else:
		window_container.show()


func _on_save_widget_close_requested():
	window.hide()


func _on_bordless_check_toggled(button_pressed):
	var window_padding: int = 25
	window.borderless = button_pressed
	
	# Adjust window size, so buttons are not hidden
	if button_pressed == false:
		window.size.y += window_padding
	else:
		window.size.y -= window_padding


func _on_top_left_pressed():
	window.position = screen_zero_position


func _on_top_right_pressed():
	window.position = Vector2i(screen_zero_position.x + screen_size.x - window.size.x, screen_zero_position.y)


func _on_bottom_left_pressed():
	window.position = Vector2i(screen_zero_position.x, screen_zero_position.y + screen_size.y - window.size.y)


func _on_bottom_right_pressed():
	window.position = Vector2i(screen_zero_position.x + screen_size.x - window.size.x, screen_zero_position.y + screen_size.y - window.size.y)


func _on_h_slider_value_changed(value):
	window.scale_size(value)
	window_scale_label.text = "Widget Scale: %1.1f" % value

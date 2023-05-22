extends Window

@onready var button_save := $Panel/HBoxContainer/SaveButton
@onready var button_insert := $Panel/HBoxContainer/InsertButton

var base_size : Vector2i

func _ready():
	base_size = size


func scale_size(scale: float) -> void:
	size = base_size * scale
	content_scale_factor = scale

extends Window

var base_size : Vector2i

func _ready():
	base_size = size


func scale_size(scale: float) -> void:
	size = base_size * scale
	content_scale_factor = scale

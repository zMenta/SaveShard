extends Window

@export var ok_icon: Texture2D
@export var error_icon: Texture2D

@onready var button_save := $Panel/HBoxContainer/SaveButton
@onready var button_insert := $Panel/HBoxContainer/InsertButton
@onready var log_texture := $Panel/HBoxContainer/MarginContainer/TextureRect
@onready var animation := $AnimationPlayer

var base_size : Vector2i

func _ready():
	base_size = size


func scale_size(scale: float) -> void:
	size = base_size * scale
	content_scale_factor = scale

func _set_ok_icon() -> void:
	log_texture.texture = ok_icon

func _set_error_icon() -> void:
	log_texture.texture = error_icon

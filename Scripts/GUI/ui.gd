extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $Control/MarginContainer/TextureProgressBar

func init_hp(max_hp: int) -> void:
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp

func update_hp(current_hp: int) -> void:
	hp_bar.value = current_hp

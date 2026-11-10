extends CanvasLayer

@onready var hp_bar: ProgressBar = $Control/MarginContainer/ProgressBar

func update_hp(current: float, max_hp: float) -> void:
	hp_bar.value = current
	hp_bar.max_value = max_hp

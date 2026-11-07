extends Node3D

@onready var player = $Player
@onready var ui = $UI

func _start() -> void:
	ui.init_hp(player.max_hp)
	
	player.hp_changed.connect(ui.update_hp)

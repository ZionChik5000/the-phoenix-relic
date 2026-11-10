extends Node3D

@onready var player = $Player
@onready var ui = $UI

func _ready() -> void:
	ui.update_hp(player.health.current_hp, player.health.max_hp)
	player.health.changed.connect(ui.update_hp)
	player.died.connect(_on_player_died)

func _on_player_died() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

class_name HealthComponent
extends Node


signal changed(current: float, max: float)
signal died

@export var max_hp: float = 100.0
var current_hp: float

func _ready() -> void:
	current_hp = max_hp

func take_damage(amount: float) -> void:
	#The check for current_hp <= 0 at the start is necessary to prevent dying from being triggered twice if the dead character is hit again.
	if current_hp <= 0.0:
		return
	current_hp = clampf(current_hp - amount, 0.0, max_hp)
	changed.emit(current_hp, max_hp)
	if current_hp <= 0.0:
		died.emit()

func heal(amount: float) -> void:
	if current_hp <= 0.0:
		return
	current_hp = clampf(current_hp + amount, 0.0, max_hp)
	changed.emit(current_hp, max_hp)

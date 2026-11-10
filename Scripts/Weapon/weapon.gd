extends Node3D

@export var weapon_data: WeaponData

@onready var model_pivot: Node3D = $ModelPivot

func _ready():
	if weapon_data == null:
		push_error("WeaponData is not assigned!")
		return

	if weapon_data.model == null:
		push_error("Weapon model is not assigned to the weapon resource!")
		return

	var model = weapon_data.model.instantiate()
	model_pivot.add_child(model)

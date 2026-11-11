extends Node3D
class_name Weapon

var _can_attack := true

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


func attack(ray: RayCast3D) -> void:
	if weapon_data == null or not _can_attack:
		return
	_can_attack = false

	ray.target_position = Vector3(0, 0, -weapon_data.reach)
	ray.force_raycast_update()
	var target := ray.get_collider()
	if target and target.has_method("take_damage"):
		target.take_damage(weapon_data.damage)

	await get_tree().create_timer(weapon_data.cooldown).timeout
	_can_attack = true

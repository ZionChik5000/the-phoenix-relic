
extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const SENSITIVITY := 0.005

signal died

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interact_ray: RayCast3D = $Head/Camera3D/RayCast3D
@onready var health: HealthComponent = $HealthComponent

@onready var weapon: Weapon = $Head/Camera3D/Hand/Weapon
@onready var attack_ray: RayCast3D = $Head/Camera3D/AttackRay


func _enter_tree() -> void:
	Global.player_node = self

func _exit_tree() -> void:
	Global.player_node = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	interact_ray.add_exception(self)
	attack_ray.add_exception(self)
	health.died.connect(die)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		return
	
	if event.is_action_pressed("interact"):
		var target := interact_ray.get_collider()
		if target and target.has_method("interact"):
			target.interact(self)
	
	# TODO add the mouse movement lock when the mouse is visible and othervise. also have to add the pause menu
	if event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("attack"):
		weapon.attack(attack_ray)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func take_damage(amount: float) -> void:
	health.take_damage(amount)

func die() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)
	died.emit()

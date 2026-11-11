extends CharacterBody3D

@onready var health: HealthComponent = $HealthComponent

func _ready() -> void:
	health.died.connect(queue_free)

func take_damage(amount: float) -> void:
	health.take_damage(amount)

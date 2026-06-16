extends Area3D

@export var belt_direction : Vector3 = Vector3.FORWARD

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("enter_conveyor"):
		body.enter_conveyor(self)

func _on_body_exited(body: Node3D) -> void:
	if body.has_method("exit_conveyor"):
		body.exit_conveyor(self)

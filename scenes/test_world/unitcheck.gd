extends Area3D

var count : int = 0
var unit_array : Array[RigidBody3D]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# TODO Punish player for jamming factory
func _on_body_entered(body: Node3D) -> void:
	if body.has_method("enter_conveyor"):
		unit_array.append(body)
		if unit_array.size() > 5:
			for unit in unit_array:
				unit.queue_free()

func _on_body_exited(body: Node3D) -> void:
	if body.has_method("exit_conveyor"):
		unit_array.remove_at(unit_array.find(body))

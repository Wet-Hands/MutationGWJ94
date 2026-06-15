extends State

@export var arms_node : Node3D

func _enter(previous_state : State) -> void:
	super._enter(previous_state)
	if state_machine.anim:
		if previous_state != self:
			state_machine.anim.play("arms_down")
	else:
		arms_node.rotation_degrees.x = -70

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	if Input.is_action_just_released("hold"):
		transition.emit("ArmsDownState")

func _physics_update(delta : float) -> void:
	pass

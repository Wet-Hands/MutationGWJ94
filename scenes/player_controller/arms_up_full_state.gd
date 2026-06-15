extends State

@export var arms_node : Node3D
@export var marker : Marker3D
@export var area : Area3D

var active : bool = false

func _enter(previous_state : State) -> void:
	super._enter(previous_state)
	target = (get_parent().target)
	if state_machine.anim:
		if previous_state != self:
			state_machine.anim.play("arms_down")
	arms_node.rotation_degrees.x = -70
	active = true

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	if Input.is_action_just_released("hold"):
		transition.emit("ArmsDownState")
		active = false

func _physics_update(delta : float) -> void:
	if active:
		if target != null:
			var a = area.get_global_transform().origin
			var b = target.get_global_transform().origin
			target.set_linear_velocity((a-b)*5)

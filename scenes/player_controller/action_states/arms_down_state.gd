extends State

@export var arms_node : Node3D
@export var ray : RayCast3D

func _enter(previous_state : State) -> void:
	super._enter(previous_state)
	if state_machine.anim:
		if previous_state != self:
			state_machine.anim.play("arms_down")
	arms_node.rotation_degrees.x = 0
	get_parent().target = null

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	if Input.is_action_just_pressed("hold"):
		var test : bool = false
		
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider:
				if collider.has_meta("UNIT"):
					get_parent().target = collider
					print(collider)
					transition.emit("ArmsUpFullState")
					return
		transition.emit("ArmsUpEmptyState")

func _physics_update(delta : float) -> void:
	pass

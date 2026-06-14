extends State

func _enter(previous_state : State) -> void:
	super._enter(previous_state)
	if state_machine.anim:
		if previous_state != self:
			state_machine.anim.play("arms_down")

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	if Input.is_action_just_pressed("hold"):
		var test : bool = true
		# TODO Check for holdable item
		if test:
			transition.emit("ArmsUpFullState")
		else:
			transition.emit("ArmsUpEmptyState")

func _physics_update(delta : float) -> void:
	pass

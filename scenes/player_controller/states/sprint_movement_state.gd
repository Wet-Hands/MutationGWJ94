extends State

@export_category("Movement")
@export var speed : float = 8.0
@export var acceleration : float = 0.5
@export var deceleration : float = 0.8

func _enter(previous_state : State) -> void:
	super._enter(previous_state)

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	target.update_gravity(delta)
	target.update_input(delta, speed, acceleration, deceleration)
	target.update_velocity()
	
	if Input.is_action_just_released("sprint"):
		transition.emit("WalkMovementState")
		return

	if target.velocity.length() <= 0.0:
		transition.emit("IdleMovementState")
		return

func _physics_update(delta : float) -> void:
	pass

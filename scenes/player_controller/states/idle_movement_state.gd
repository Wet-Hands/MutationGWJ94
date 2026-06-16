extends State

@export_category("Player Movement")
@export var speed : float = 8
@export var acceleration : float = .5
@export var deceleration : float = .8

func _enter(previous_state : State) -> void:
	super._enter(previous_state)

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	target.update_gravity(delta)
	target.update_input(delta, speed, acceleration, deceleration)
	target.update_velocity()

	if target.velocity.length() > 0.0:
		transition.emit("WalkMovementState")
		return

func _physics_update(delta : float) -> void:
	pass

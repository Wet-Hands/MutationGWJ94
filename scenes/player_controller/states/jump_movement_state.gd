extends State

@export var speed : float = 8
@export var acceleration : float = .5
@export var deceleration : float = .8

@export var jump_velocity : float = 4.5

func _enter(previous_state : State) -> void:
	super._enter(previous_state)
	speed = (previous_state.speed / 1.2)
	target.velocity.y += jump_velocity

func _exit() -> void:
	pass

func _update(delta : float) -> void:
	target.update_gravity(delta)
	target.update_input(delta, peed, acceleration, deceleration)
	target.update_velocity()
	
	if target.velocity.y <= 0:
		transition.emit("FallMovementState")

	if target.is_on_floor():
		transition.emit("IdleMovementState")
		return

func _physics_update(delta : float) -> void:
	pass

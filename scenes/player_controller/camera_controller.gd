class_name CameraController 
extends Node3D

@export var debug : bool = false

@export_category("References")
@export var player_controller : PlayerCharacter
@export var analog_component : AnalogCaptureComponent
@export var health_component : HealthComponent
@export var anchor : Marker3D

@export_category("Camera Settings")
@export_group("Camera Tilt")
@export_range(-90, 0) var tilt_lower_limit : int = -90
@export_range(0, 90) var tilt_upper_limit : int = 90
@export_group("Headbob")
@export_range(0.0, 0.1, 0.001) var bob_pitch : float = 0.05
@export_range(0.0, 0.1, 0.001) var bob_roll : float = 0.025
@export_range(0.0, 0.04, 0.001) var bob_up : float = 0.005
@export_range(3.0, 8.0, 0.1) var bob_frequency : float = 6.0

var _step_timer : float = 0.0
@export_group("Weapon Sway")

var _rotation : Vector3

func _process(delta: float) -> void:
	var input := analog_component.consume_input()
	update_camera_rotation(input)

func update_camera_rotation(input: Vector2) -> void:
	_rotation.x += input.y
	_rotation.y += input.x
	_rotation.x = clamp(_rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit))

	player_controller.update_rotation(Vector3(0.0, _rotation.y, 0.0))
	transform.basis = Basis.from_euler(Vector3(_rotation.x, 0.0, 0.0))
	_rotation.z = 0.0

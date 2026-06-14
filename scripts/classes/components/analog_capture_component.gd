@icon("res://assets/components/MouseCaptureComponentNode.svg")
class_name AnalogCaptureComponent 
extends Component
## Used for getting mouse and joystick movement.
##
## Designed to be used with a CameraController
##

@export_category("Mouse Capture Settings")
@export var current_mouse_mode : Input.MouseMode = Input.MOUSE_MODE_CAPTURED
@export var mouse_sensitivity : float = 0.005
@export var joy_sensitivity : float = .05

var _capture_mouse : bool
var _capture_joy : bool

var _mouse_input : Vector2
var _joy_input : Vector2

func _physics_process(delta: float) -> void:
	if _capture_joy:
		var _joy_x : float = Input.get_axis("joy_look_right", "joy_look_left")
		var _joy_y : float = Input.get_axis("joy_look_up", "joy_look_down")
		_joy_input = Vector2(_joy_x, _joy_y) * joy_sensitivity

func _unhandled_input(event: InputEvent) -> void:
	_capture_mouse = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	_capture_joy = event is InputEventJoypadMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if _capture_mouse:
		_mouse_input.x += -event.screen_relative.x * mouse_sensitivity
		_mouse_input.y += -event.screen_relative.y * mouse_sensitivity
	if debug: print(_mouse_input)

func _ready() -> void:
	Input.mouse_mode = current_mouse_mode

func consume_input() -> Vector2:
	var input := _mouse_input + _joy_input
	_mouse_input = Vector2.ZERO
	_joy_input = Vector2.ZERO
	return input

#----------------#
# Public Methods #
#----------------#

func play_controller_vibration() -> void:
	pass

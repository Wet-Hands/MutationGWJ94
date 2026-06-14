@icon("res://assets/components/DungeonComponent3d.svg")
class_name DungeonComponent3D
extends Component3D
## Experimental component for creating procedually generated indoor environments.
## 
## [INDEV] Designed to be used with 3D scenes that contain endpoint nodes.
##
## @experimental

@export var generate_on_start : bool = true
@export_range(0, 128) var maximum_room_count : int = 5

@export_category("Room Arrays")
@export var content_rooms : Array[Node]
@export var hall_rooms : Array[Node]
@export var arena_rooms : Array[Node]

var current_room_count : int = 0
var current_rooms : Array[Node]

func _ready() -> void:
	if generate_on_start:
		pass

func generate_rooms() -> void:
	for i in range(current_room_count, maximum_room_count):
		pass

func add_room() -> void:
	pass

func del_room() -> void:
	pass

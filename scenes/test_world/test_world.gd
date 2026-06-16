extends Node3D

@export var unit_scene : PackedScene
@export var mesh_array : Array[Mesh]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func create_unit() -> void:
	var unit = unit_scene.instantiate()
	unit.position = $Marker3D.position
	add_child(unit)
	unit.update_color(Color(1.0, 0.0, 0.0, 1.0))
	unit.update_shape(mesh_array[0])


func _on_timer_timeout() -> void:
	$Timer.stop()
	create_unit()
	$Timer.start()

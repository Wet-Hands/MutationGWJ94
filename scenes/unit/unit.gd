extends RigidBody3D

@export var mesh_array : Array[Mesh]
@export var mesh_instance : MeshInstance3D
@export var hit_sfx : AudioStream

@export var conveyor_force : float = 5.0
@export var conveyor_velocity_threshold : float = 3.0

var _was_colliding : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_contacts_reported = 4
	contact_monitor = true
	generate()

func generate(mesh : Mesh = mesh_array.pick_random(), color : Color = Color(1.0, 1.0, 1.0, 0.0)) -> void:
	mesh_instance.mesh = mesh_array.pick_random()
	mesh_instance.create_convex_collision()
	mesh_instance.get_child(0).get_child(0).reparent(self)
	mesh_instance.get_child(0).queue_free()

func check_collision_entered() -> bool:
	var is_colliding = get_contact_count() > 0
	
	if is_colliding && !_was_colliding:
		_was_colliding = true
		return true
	elif !is_colliding:
		_was_colliding = false
	
	return false

func _physics_process(delta: float) -> void:
	if check_collision_entered():
		$AudioComponent.play_audio3d(hit_sfx, self.position, 50, .1, "SFX")
	_handle_conveyor(delta)

func update_color(color : Color) -> void:
	mesh_instance.material_override.albedo_color = color

func update_shape(mesh : Mesh) -> void:
	gravity_scale = 0
	mesh_instance.mesh = mesh
	delete_col()
	mesh_instance.create_convex_collision()
	mesh_instance.get_child(1).get_child(0).reparent(self)
	gravity_scale = 1

func delete_col():
	for child in get_children():
		if child is CollisionShape3D:
			child.queue_free()

var _conveyor_areas : Array[Area3D] = []

func enter_conveyor(area: Area3D) -> void:
	_conveyor_areas.append(area)
	_set_rotation_lock(true)

func exit_conveyor(area: Area3D) -> void:
	_conveyor_areas.erase(area)
	if _conveyor_areas.is_empty():
		_set_rotation_lock(false)

func _set_rotation_lock(locked: bool) -> void:
	axis_lock_angular_x = locked
	axis_lock_angular_y = locked
	axis_lock_angular_z = locked

func _handle_conveyor(delta: float) -> void:
	if _conveyor_areas.is_empty():
		return

	for area in _conveyor_areas:
		if linear_velocity.length() < conveyor_velocity_threshold:
			apply_central_force(area.belt_direction * 100 * conveyor_force * delta)

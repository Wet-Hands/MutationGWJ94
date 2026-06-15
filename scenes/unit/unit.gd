extends RigidBody3D

@export var mesh_array : Array[Mesh]
@export var mesh_instance : MeshInstance3D
@export var hit_sfx : AudioStream

var _was_colliding : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh_instance.mesh = mesh_array.pick_random()
	mesh_instance.create_convex_collision()
	mesh_instance.get_child(0).get_child(0).reparent(self)
	mesh_instance.get_child(0).queue_free()
	
	max_contacts_reported = 4
	contact_monitor = true

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
		$AudioComponent.play_audio3d(hit_sfx, self.position, 50, .75, "SFX")

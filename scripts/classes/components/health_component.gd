@icon("res://assets/components/HealthComponentNode.svg")
class_name HealthComponent
extends Component
## Component for handling the health and death of an entity.
##
## @deprecated: Use [ResourceComponent] instead.

@export var current_health : float = 100.0
@export var maximum_health : float = 100.0

@export var is_dead : bool = false

var damage_dictionary : Dictionary[Node, float]

signal health_changed(new_health : float)
signal died

func change_current_health(amount : float, source : Node = null) -> void:
	if is_dead: return
	
	current_health += amount
	if current_health < 0.0:
		set_current_health(0.0)
		return
	health_changed.emit(current_health)
	
	if current_health == 0.0:
		died.emit()

## Sets Current Health to New Health. Returns if Dead. 
func set_current_health(new_health : float, source : Node = null) -> void:
	if is_dead: return
	
	# If planning to set health to below zero, try again at zero
	if new_health < 0.0:
		set_current_health(0.0)
		return
		
	current_health = new_health
	health_changed.emit(current_health)
	
	if current_health == 0.0:
		died.emit()

func update_dmg_dictionary(source : Node, amount : float) -> void:
	if source == null: return
	var current_dmg : float = get_dmg_from_source(source)
	damage_dictionary.set(source, current_dmg + amount)

func get_dmg_from_source(source : Node) -> float:
	if damage_dictionary.has(source):
		return damage_dictionary.get(source)
	return 0.0

func _ready() -> void:
	died.connect(_on_died)

func _on_died() -> void:
	is_dead = true
	current_health = 0.0

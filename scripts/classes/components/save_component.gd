@icon("res://assets/components/save_component_node.svg")
class_name SaveComponent
extends Component
## Experimental component for reading and writing save data for simple use cases
##
## Each SaveComponent has their own save file, this can be as big or small as needed.
##
## @experimental

var values_dictionary : Dictionary[String, String]

func _ready() -> void:
	pass

func _read_files() -> void:
	pass

func _write_files() -> void:
	pass

#----------------#
# Public Methods #
#----------------#

func create_save(category : String, value : String) -> void:
	if does_save_exist(category):
		update_save(category, value)
	
	if debug: print("Creating Category: ", category, " | Setting Value: ", value)
	values_dictionary.set(category, value)

func update_save(category : String, value : String) -> void:
	if !does_save_exist(category): return
	if debug: print("Updating Category: ", category, " | New Value: ", value)
	values_dictionary.set(category, value)

func get_save(category : String) -> String:
	if !does_save_exist(category): return "N/A"
	if debug: print("Fetching Value from Category: ", category, " | Returned: ", values_dictionary.get(category))
	return values_dictionary.get(category)

func does_save_exist(category : String) -> bool:
	if debug: print("Checking for Category: ", category, " | Returned: ", values_dictionary.has(category))
	return values_dictionary.has(category)

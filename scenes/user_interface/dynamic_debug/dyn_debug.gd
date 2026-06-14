extends Container

@export var debug : bool = false

var value_dictionary : Dictionary[String, String]
var container_dictionary : Dictionary[String, Container]

signal category_created(category_name)
signal category_deleted(category_name)
signal value_updated(new_value)

func _ready() -> void:
	if Global.dyn_debug != null:
		push_warning("DynDebug Already in Use")
		return

#----------------#
# Public Methods #
#----------------#

func create_category(name : String, value : String, horizontal : bool = false) -> void:
	if does_category_exist(name, false):
		push_warning("Category Already Exists: ", name)
		return
	
	value_dictionary.set(name, value)
	
	# Create Category Name & Value Labels, will be children of another container
	var name_label := Label.new()
	name_label.text = (name + ": ")
	var value_label := Label.new()
	value_label.text = value
	
	if !horizontal:
		var hbox := HBoxContainer.new()
		hbox.name = (name + "Container")
		
		add_child(hbox)
		
		hbox.add_child(name_label)
		hbox.add_child(value_label)
		container_dictionary.set(name, hbox)
	else:
		var vbox := VBoxContainer.new()
		vbox.name = (name + "Container")
		
		vbox.add_child(name_label)
		vbox.add_child(value_label)
		container_dictionary.set(name, vbox)

func update_value(category : String, new_value : String) -> void:
	if !does_category_exist(category, true): 
		print("Category Doesn't Exist")
		return
	value_dictionary.set(category, new_value)
	container_dictionary.get(category).get_child(1).text = new_value
	value_updated.emit(new_value)

func get_value(category : String) -> String:
	if !does_category_exist(category, true): return "N/A"
	return value_dictionary.get(category)

func get_container(category : String) -> Container:
	if !does_category_exist(category, true): return null
	return container_dictionary.get(category)

func does_category_exist(category : String, verbose : bool) -> bool:
	if value_dictionary.has(category):
		if debug: print("Found Category: ", category)
		return true
	else:
		if verbose or debug: push_warning("Category Doesn't Exist: ", category)
		return false

func delete_category(category : String) -> void:
	if !does_category_exist(category, true): return
	container_dictionary.get(category).queue_free()
	
	value_dictionary.erase(category)
	container_dictionary.erase(category)
	
	category_deleted.emit(category)

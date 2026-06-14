extends MarginContainer

@export var dev_world : PackedScene
@export var credits_container : VBoxContainer
@export var settings_container : VBoxContainer

var current_container : VBoxContainer

func _ready() -> void:
	for child in %MainContainer.get_children():
		if child is Button:
			child.pressed.connect(_on_button_pressed.bind(child.name))
	
	%BackButton.pressed.connect(_on_button_pressed.bind(%BackButton.name))
	if settings_container:
		settings_container.back_button.pressed.connect(_on_button_pressed.bind(settings_container.back_button.name))
	set_container(%MainContainer)

func set_container(new_container : VBoxContainer) -> void:
	for child in %MarginContainer.get_children():
		child.hide()
	new_container.show()

func _on_button_pressed(button_name : String) -> void:
	match button_name:
		"BackButton":
			set_container(%MainContainer)
		"PlayButton":
			pass
		"DevButton":
			if dev_world: get_tree().change_scene_to_packed(dev_world)
		"SettingsButton":
			if settings_container: set_container(settings_container)
		"CreditsButton":
			set_container(credits_container)
		"QuitButton":
			get_tree().quit()

@icon("res://assets/components/SteamComponentNode.svg")
class_name SteamComponent
extends Component

var steam_id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Steam.isSteamRunning(): 
		push_warning("Steam is not Running")
		return
	
	steam_id = Steam.getSteamID()

func get_steam_id() -> int:
	if !Steam.isSteamRunning():
		push_warning("Steam is not Running")
		return 0
	return steam_id

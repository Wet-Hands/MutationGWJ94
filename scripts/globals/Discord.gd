extends Node

var debug : bool = false

var discord_app_id : int = 0000000000000000000

func _ready():
	# Application ID
	DiscordRPC.app_id = discord_app_id
	
	# this is boolean if everything worked
	print("Discord working: " + str(DiscordRPC.get_is_discord_working()))
	
	# "02:41 elapsed" timestamp for the activity
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	
	# Always refresh after changing the values!
	DiscordRPC.refresh()

# Set the first custom text row of the activity here
func update_details(str : String) -> void:
	DiscordRPC.details = str
	if debug: print("New DiscordRPC Details: ", DiscordRPC.details)
	DiscordRPC.refresh()

# Set the second custom text row of the activity here
func update_state(str : String) -> void:
	DiscordRPC.state = str
	if debug: print("New DiscordRPC State: ", DiscordRPC.state)
	DiscordRPC.refresh()

# Image key for small image from "Art Assets" from the Discord Developer website
func update_large_image(str : String) -> void:
	DiscordRPC.large_image = str
	if debug: print("New DiscordRPC State: ", DiscordRPC.large_image)
	DiscordRPC.refresh()

# Tooltip text for the large image
func update_large_image_text(str : String) -> void:
	DiscordRPC.large_image_text = str
	if debug: print("New DiscordRPC State: ", DiscordRPC.large_image_text)
	DiscordRPC.refresh()

# Image key for small image from "Art Assets" from the Discord Developer website
func update_small_image(str : String) -> void:
	DiscordRPC.small_image = str
	if debug: print("New DiscordRPC State: ", DiscordRPC.small_image)
	DiscordRPC.refresh()

# Tooltip text for the small image
func update_small_image_text(str : String) -> void:
	DiscordRPC.small_image_text = str
	if debug: print("New DiscordRPC State: ", DiscordRPC.small_image_text)
	DiscordRPC.refresh()

func update_end_timestamp(end_time : int) -> void:
	DiscordRPC.end_timestamp = end_time
	# Example for (59:59 Remaining)
	#DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 

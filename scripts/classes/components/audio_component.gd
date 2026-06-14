@icon("res://assets/components/AudioComponentNode.svg")
class_name AudioComponent
extends Component
## Plays Audio by passing through an AudioStream file
##
## Creates, manages, and deletes AudioStreamPlayer and AudioStreamPlayer3D
##

signal audio_started

func destroy_audio_player(audio_player : Node) -> void:
	if debug: print("Destroying AudioPlayer: ", audio_player)
	audio_player.stop()
	audio_player.queue_free()

#----------------#
# Public Methods #
#----------------#

func play_audio(stream : AudioStream, volume_linear : float = 100) -> void:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = linear_to_db(volume_linear)
	
	player.connect("finished", destroy_audio_player.bind(player))
	add_child(player)
	player.play()
	
	if debug: print("Playing AudioStream: ", stream)
	audio_started.emit()

func play_audio3d(stream : AudioStream, position : Vector3, volume_linear : float = 100, unit_size : float = 10.0, bus : StringName = "Master") -> void:
	var player := AudioStreamPlayer3D.new()
	player.stream = stream
	player.position = position
	player.volume_db = linear_to_db(volume_linear)
	player.unit_size = unit_size
	player.bus = bus
	
	player.connect("finished", destroy_audio_player.bind(player))
	add_child(player)
	player.play()
	
	if debug: print("Playing AudioStream: ", stream, " | Position: ", str(position))
	audio_started.emit()

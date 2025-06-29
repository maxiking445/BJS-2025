extends Node


@export var sounds = {
	"heartbeat": preload("res://sounds/heartbeat.mp3"),
	"timer": preload( "res://sounds/timer.mp3"),
}

var audio_player: AudioStreamPlayer

func _ready():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
func fadeOutSound(audio_player: AudioStreamPlayer2D, duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(audio_player, "volume_db", -80, duration)  # -80 dB = quasi stumm
	
func playHeartbeat():
	play_sound("heartbeat")
	
func play_sound(name: String):
	if not sounds.has(name):
		return
	audio_player.stream = sounds[name]
	audio_player.play()

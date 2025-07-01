extends Node


@export var sounds = {
	"heartbeat": preload("res://sounds/heartbeat.mp3"),
	"timer": preload( "res://sounds/timer.mp3"),
	"whispers": preload( "res://sounds/whisper.mp3"),
}


	
func fadeOutSound(audio_player: AudioStreamPlayer, duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(audio_player, "volume_db", -80, duration)  # -80 dB = quasi stumm
	
func playHeartbeat(parent: Node)-> AudioStreamPlayer:
	var audioplayer = createAudioPlayer(parent)
	play_sound("heartbeat", audioplayer)
	return audioplayer

func playWhispers(parent: Node)-> AudioStreamPlayer:
	var audioplayer = createAudioPlayer(parent)
	play_sound("whispers", audioplayer)
	return audioplayer

func  createAudioPlayer(parent: Node):
	var audio_player = AudioStreamPlayer.new()
	parent.add_child(audio_player)
	return audio_player
	
func play_sound(name: String, audio_player):
	if not sounds.has(name):
		return
	audio_player.stream = sounds[name]
	audio_player.play()

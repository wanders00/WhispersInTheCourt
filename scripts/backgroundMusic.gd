extends Node

var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	music_player.stream = preload("res://dance-of-gypsy-monkey-giulio-fazio-main-version-01-21-15246.mp3") # Adjust the path to your music file
	#music_player.loop = true # Enable looping
	music_player.play()
	music_player.volume_db = 1.0 # Adjust vo§lume as needed

func play_music(stream):
	music_player.stream = stream
	music_player.play()

func stop_music():
	music_player.stop()

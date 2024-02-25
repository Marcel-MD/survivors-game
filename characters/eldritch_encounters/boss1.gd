extends Node2D


func play_walk():
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")


func _on_music_player_finished():
	%MusicPlayer.play()

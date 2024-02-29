extends Node2D


func _on_play_button_pressed():
	%AnimationPlayer.play("play")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_music_player_finished():
	%MusicPlayer.play()


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://game.tscn")

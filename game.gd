extends Node2D

@onready var player = get_node("/root/Game/Player")
const ENEMY = preload("res://enemy.tscn")

func spawn_enemy():
	var enemy = ENEMY.instantiate()
	%EnemyPathFollow2D.progress_ratio = randf()
	enemy.global_position = %EnemyPathFollow2D.global_position
	add_child(enemy)

var enemies_spawned = 0

func _on_timer_timeout():
	spawn_enemy()
	
	enemies_spawned += 1
	if enemies_spawned == 50:
		$EnemySpawnTimer.wait_time = 0.5
	
	if enemies_spawned == 150:
		$EnemySpawnTimer.wait_time = 0.3
	
	if enemies_spawned == 300:
		$EnemySpawnTimer.wait_time = 0.1


func _on_player_health_depleted():
	%GameOverScreen.visible = true
	get_tree().paused = true


func _on_heal_button_pressed():
	if player.score < 10:
		return
		
	player.increment_score(-10)
	player.heal()


func _on_armor_button_pressed():
	if player.score < 20:
		return
		
	player.increment_score(-20)
	player.increase_armor()


func _on_speed_button_pressed():
	if player.score < 20:
		return
		
	player.increment_score(-20)
	player.increase_speed()


func _on_gun_button_pressed():
	if player.score < 40:
		return
		
	player.increment_score(-40)
	player.add_new_gun()


func _on_music_player_finished():
	$MusicPlayer.play()

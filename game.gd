extends Node2D

@onready var player = get_node("/root/Game/Player")
const ENEMY = preload("res://enemy.tscn")
var enemies_spawned = 0

func spawn_enemy():
	var enemy = ENEMY.instantiate()
	
	var seed = randf()
	if seed < 0.1:
		enemy.create_enemy("VESPERMORPH")
	elif seed < 0.3:
		enemy.create_enemy("ASTROGOR")
	else:
		enemy.create_enemy("MORBITH")
	
	%EnemyPathFollow2D.progress_ratio = randf()
	enemy.global_position = %EnemyPathFollow2D.global_position
	add_child(enemy)


func spawn_boss(number):
	var enemy = ENEMY.instantiate()
	
	match number:
		1:
			enemy.create_boss("BOSS1", player.speed)
		2:
			enemy.create_boss("BOSS2", player.speed)
		3:
			enemy.create_boss("BOSS3", player.speed)
		
	%EnemyPathFollow2D.progress_ratio = randf()
	enemy.global_position = %EnemyPathFollow2D.global_position
	add_child(enemy)


func _on_timer_timeout():
	spawn_enemy()
	enemies_spawned += 1
	
	if enemies_spawned == 50:
		$EnemySpawnTimer.wait_time = 0.5
		spawn_boss(1)
	if enemies_spawned == 150:
		$EnemySpawnTimer.wait_time = 0.3
		spawn_boss(2)
	if enemies_spawned == 300:
		$EnemySpawnTimer.wait_time = 0.1
		spawn_boss(3)
	if enemies_spawned == 500:
		spawn_boss(1)
		spawn_boss(2)
		spawn_boss(3)


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
	player.armor -= 0.2
	if player.armor <= 0.3:
		%ArmorButton.queue_free() 


func _on_speed_button_pressed():
	if player.score < 30:
		return
		
	player.increment_score(-30)
	player.speed += 100
	if player.speed >= 1000:
		%SpeedButton.queue_free() 

var guns = 0

func _on_gun_button_pressed():
	if player.score < 50:
		return
		
	guns += 1
	player.increment_score(-50)
	player.add_new_gun()
	
	if guns >= 3:
		%GunButton.queue_free()
		


func _on_music_player_finished():
	$MusicPlayer.play()

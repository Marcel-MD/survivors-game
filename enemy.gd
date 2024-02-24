extends CharacterBody2D

const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
const MORBITH = preload("res://characters/eldritch_encounters/morbith.tscn")
const ASTROGOR = preload("res://characters/eldritch_encounters/astrogor.tscn")
const VESPERMORPH = preload("res://characters/eldritch_encounters/vespermorph.tscn")
const BOSS1 = preload("res://characters/eldritch_encounters/boss1.tscn")
@onready var player = get_node("/root/Game/Player")

var enemy
var speed = 300
var health = 3
var damage = 30
var score = 1

	
func create_enemy(name):
	match name:
		"MORBITH":
			enemy = MORBITH.instantiate()
		"VESPERMORPH":
			enemy = VESPERMORPH.instantiate()
			speed = 300
			health = 6
			damage = 50
			score = 3
		"ASTROGOR":
			enemy = ASTROGOR.instantiate()
			speed = 500
			health = 4
			score = 2
	
	add_child(enemy)
	enemy.play_walk()


func create_boss(name, player_speed):
	match name:
		"BOSS1":
			enemy = BOSS1.instantiate()
			speed = player_speed - 100
			health = 100
			damage = 100
			score = 10
		"BOSS2":
			enemy = BOSS1.instantiate()
			speed = player_speed - 50
			health = 200
			damage = 200
			score = 20
		"BOSS3":
			enemy = BOSS1.instantiate()
			speed = player_speed
			health = 400
			damage = 400
			score = 40
	
	%CollisionShape2D.scale.x = 1.8
	%CollisionShape2D.scale.y = 1.8
	add_child(enemy)
	enemy.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()


func take_damage():
	enemy.play_hurt()
	health -= 1
	
	if health == 0:
		player.increment_score(score)
		queue_free()
		var smoke = SMOKE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

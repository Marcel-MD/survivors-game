extends CharacterBody2D

const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
const MORBITH = preload("res://characters/eldritch_encounters/morbith.tscn")
const ASTROGOR = preload("res://characters/eldritch_encounters/astrogor.tscn")
const VESPERMORPH = preload("res://characters/eldritch_encounters/vespermorph.tscn")
@onready var player = get_node("/root/Game/Player")

var enemy
var speed = 300
var health = 3
var damage = 30
var score = 1

func _ready():
	var seed = randf()
	if seed < 0.2:
		enemy = VESPERMORPH.instantiate()
		speed = 200
		health = 6
		damage = 50
		score = 3
	elif seed < 0.5:
		enemy = ASTROGOR.instantiate()
		speed = 500
		health = 4
		score = 2
	else:
		enemy = MORBITH.instantiate()
		
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

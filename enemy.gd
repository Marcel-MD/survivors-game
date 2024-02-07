extends CharacterBody2D

var health = 3
const SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()


func take_damage():
	$Slime.play_hurt()
	health -= 1
	
	if health == 0:
		player.increment_score(1)
		queue_free()
		var smoke = SMOKE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

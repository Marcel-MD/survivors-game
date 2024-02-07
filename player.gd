extends CharacterBody2D

@onready var score_label = get_node("/root/Game/CanvasLayer/ScoreLabel")
const GUN = preload("res://gun.tscn")
signal health_depleted
var damage_rate = 30.0
var health = 100.0
var speed = 600
var score = 0

func increment_score(amount):
	score += amount
	update_score_label()

func add_new_gun():
	var gun = GUN.instantiate()
	add_child(gun)

func heal():
	health = 100
	%HealthBar.value = health
	
func increase_speed():
	speed += 150
	
func decrease_damage_rate():
	if damage_rate > 5.0:
		damage_rate -= 5.0
	

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		health -= damage_rate * overlapping_enemies.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()


func update_score_label():
	score_label.text = "Score: " + str(score)

extends KinematicBody2D


var velocity := Vector2.ZERO
var speed := 100
var normal_shot = preload("res://Scenes/ProjectileNormal.tscn")
var active_power :String
var health := 5
var max_health := 5

var shield_scene = preload("res://Scenes/Shields.tscn")
var shielded := false

var multi_shot := false
var speedboost := false

onready var anim_player = $AnimationPlayer
onready var LeftShootPosition = $LeftProjectilePosition
onready var RightShootPosition = $RightProjectilePosition


#warning-ignore:unused_argument
func _process(delta):
	movement()
	animate()
	shooting()
	#warning-ignore:return_value_discarded
	move_and_slide(velocity)


func movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("TurnRight") and not position.x > 208:
		velocity.x = speed

	if Input.is_action_pressed("TurnLeft") and not position.x < 16:
		velocity.x = -speed
	
	if Input.is_action_pressed("Forward") and not position.y < 16:
		velocity.y = -speed
		
	if Input.is_action_pressed("Backward") and not position.y > 348:
		velocity.y = speed

	velocity = velocity.normalized() * speed


func animate():
	if velocity.x > 0:
		anim_player.play("TurnRight")
	
	elif velocity.x < 0:
		anim_player.play("TurnLeft")
	
	else:
		anim_player.play("Idle")
	

func shooting():
	if Input.is_action_just_pressed("Shoot"):
		if !multi_shot:
			var shot_inst = normal_shot.instance()
			var shot_inst2 = normal_shot.instance()
			shot_inst.position = LeftShootPosition.global_position
			shot_inst2.position = RightShootPosition.global_position
			get_parent().add_child(shot_inst)
			get_parent().add_child(shot_inst2)
		
		elif multi_shot:
			var shot_inst = normal_shot.instance()
			var shot_inst2 = normal_shot.instance()
			var shot_inst3 = normal_shot.instance()
			var shot_inst4 = normal_shot.instance()
			shot_inst.position = LeftShootPosition.global_position
			shot_inst2.position = RightShootPosition.global_position
			shot_inst3.position = LeftShootPosition.global_position
			shot_inst4.position = RightShootPosition.global_position
			
			shot_inst.velocity.x = -50
			shot_inst2.velocity.x = -50
			shot_inst3.velocity.x = 50
			shot_inst4.velocity.x = 50
			
			get_parent().add_child(shot_inst)
			get_parent().add_child(shot_inst2)
			get_parent().add_child(shot_inst3)
			get_parent().add_child(shot_inst4)


func hit(damage):
	if not shielded:
		health -= damage
		get_tree().call_group("GUI", "update_bar", "HealthBar", health)
		if health <= 0:
			get_tree().call_group("GUI", "game_over")
			get_tree().paused = true
			self.queue_free()
	else:
		shielded = false
		get_tree().call_group("GUI", "update_bar", "ShieldBar", 0)
		$Shields.queue_free()


func health_up(amount):
	if health < max_health:
		health += amount
		get_tree().call_group("GUI", "update_bar", "HealthBar", health)


func enable_speed(multiplier):
	speed = speed * multiplier
	get_tree().call_group("GUI", "update_bar", "SpeedBar", 1)
	yield(get_tree().create_timer(5), "timeout")
	speed = speed / multiplier
	get_tree().call_group("GUI", "update_bar", "SpeedBar", 0)


func shield_activate():
	var shield_inst = shield_scene.instance()
	self.add_child(shield_inst)
	get_tree().call_group("GUI", "update_bar", "ShieldBar", 1)
	shielded = true


func enable_multi_shot():
	multi_shot = true
	get_tree().call_group("GUI", "update_bar", "MultiShotBar", 1)
	yield(get_tree().create_timer(5), "timeout")
	multi_shot = false
	get_tree().call_group("GUI", "update_bar", "MultiShotBar", 0)




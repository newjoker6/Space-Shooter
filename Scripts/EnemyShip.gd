extends KinematicBody2D

var velocity := Vector2.ZERO
var speed := 100
var health := 3

var time
var shot = preload("res://Scenes/ProjectileNormal.tscn")

var explosion = preload("res://Scenes/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(50, 200)
	velocity.y = speed
	time = rand_range(1, 2)
	$ShotTimer.wait_time = time
	$ShotTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_position()
	move_and_slide(velocity)


func _on_ShotTimer_timeout():
	if not $RayCast2D.is_colliding():
		var shot_inst = shot.instance()
		shot_inst.position = $ShotPos.global_position
		get_parent().get_parent().add_child(shot_inst)
		shot_inst.velocity.y = shot_inst.speed
		shot_inst.modulate = Color.lime
	
	$ShotTimer.start()


func hit(damage):
	health -= damage
	if health <= 0:
		var exp_inst = explosion.instance()
		exp_inst.position = self.position
		get_parent().add_child(exp_inst)
		exp_inst.one_shot = true
		self.queue_free()


func check_position():
	if self.position.y > 450:
		queue_free()
